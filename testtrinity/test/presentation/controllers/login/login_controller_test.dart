import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testtrinity/infrastructure/data/data_sources/local/storage_local.dart';
import 'package:testtrinity/domain/entities/data_json/data_json_model.dart';
import 'package:testtrinity/presentation/controllers/login/login_controller.dart';

class MockStorageLocal extends Mock implements StorageLocal {}

class MockDataJsonModel extends Mock implements DataJsonModel {}

void main() {
  late LoginController controller;
  late MockStorageLocal mockStorageLocal;
  late MockDataJsonModel mockDataJsonModel;

  setUp(() {
    mockStorageLocal = MockStorageLocal();
    mockDataJsonModel = MockDataJsonModel();
    controller = LoginController();
    Get.put<StorageLocal>(mockStorageLocal);
    Get.put<DataJsonModel>(mockDataJsonModel);
  });

  tearDown(() {
    Get.delete<StorageLocal>();
    Get.delete<DataJsonModel>();
    Get.delete<LoginController>();
  });

  group('LoginController Test', () {
    test('Initial values are correct', () {
      expect(controller.userID.value, '');
    });

    test('setUserID updates userID', () {
      controller.setUserID('new_user_id');
      expect(controller.userID.value, 'new_user_id');
    });

    test('validateEmptyFieldFirstName returns true for non-empty string', () {
      expect(controller.validateEmptyFieldFirstName('test'), true);
    });

    test('validateEmptyFieldFirstName returns false for empty string', () {
      expect(controller.validateEmptyFieldFirstName(''), false);
    });
  });
}
