import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testtrinity/domain/entities/data_json/data_json_model.dart';
import 'package:testtrinity/infrastructure/data/data_sources/local/storage_local.dart';
import 'package:testtrinity/presentation/controllers/home/home_controller.dart';

class MockStorageLocal extends Mock implements StorageLocal {}

class MockDataJsonModel extends Mock implements DataJsonModel {}

void main() {
  late HomeController controller;
  late MockStorageLocal mockStorageLocal;
  late MockDataJsonModel mockDataJsonModel;

  setUp(() {
    mockStorageLocal = MockStorageLocal();
    mockDataJsonModel = MockDataJsonModel();
    controller = HomeController();
    Get.put<StorageLocal>(mockStorageLocal);
    Get.put<DataJsonModel>(mockDataJsonModel);
  });

  tearDown(() {
    Get.delete<StorageLocal>();
    Get.delete<DataJsonModel>();
    Get.delete<HomeController>();
  });

  group('HomeController Test', () {
    test('Initial values are correct', () {
      expect(controller.selectedPage.value, 0);
      expect(controller.search.value, '');
      expect(controller.userID.value, '');
      expect(controller.name.value, '');
      expect(controller.email.value, '');
      expect(controller.dateOfBirth.value, '');
      expect(controller.isFilled.value, false);
      expect(controller.enableFlag.value, false);
      expect(controller.listData.length, 20); // Assuming initial data length
    });

    test('setSearch updates search value and isFilled', () {
      controller.setSearch('Phoebe');
      expect(controller.search.value, 'Phoebe');
      expect(controller.isFilled.value, true);
    });

    test('flagText sets enableFlag to true if userID matches', () {
      controller.userID.value = '5c8a80f52dfee238898d64cf';
      controller.flagText();
      expect(controller.enableFlag.value, true);
    });

    test('profileData sets name, email, and dateOfBirth based on userID', () {
      controller.userID.value = '5c8a80f52dfee238898d64cf';
      controller.profileData();
      expect(controller.name.value, 'Phoebe Monroe');
      expect(controller.email.value, 'phoebemonroe@furnafix.com');
      expect(controller.dateOfBirth.value, '3/2/1982');
    });
  });
}
