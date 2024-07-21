import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testtrinity/presentation/controllers/home/home_controller.dart';
import 'package:testtrinity/presentation/controllers/contact_detail/contact_detail_controller.dart';

class MockHomeController extends GetxController
    with Mock
    implements HomeController {}

void main() {
  late ContactDetailController controller;
  late MockHomeController mockHomeController;

  setUp(() {
    mockHomeController = MockHomeController();
    Get.put<HomeController>(mockHomeController);
    controller = ContactDetailController();
  });

  tearDown(() {
    Get.delete<HomeController>();
    Get.delete<ContactDetailController>();
  });

  group('ContactDetailController Test', () {
    test('Initial values are correct', () {
      expect(controller.firstName.value, '');
      expect(controller.lastName.value, '');
      expect(controller.email.value, '');
      expect(controller.name.value, '');
      expect(controller.selectedDate.value, '');
      expect(controller.isFilled.value, false);
      expect(controller.enableCreate.value, false);
      expect(controller.disableRemove.value, false);
    });

    test('Set first name updates first name and validates form', () {
      controller.setFirstName(value: 'John');
      expect(controller.firstName.value, 'John');
      expect(controller.isFilled.value, false);
    });

    test('Set last name updates last name and validates form', () {
      controller.setLastname(value: 'Doe');
      expect(controller.lastName.value, 'Doe');
      expect(controller.isFilled.value, false);
    });

    test(
        'Validate form sets isFilled to true if first and last name are not empty',
        () {
      controller.setFirstName(value: 'John');
      controller.setLastname(value: 'Doe');
      expect(controller.isFilled.value, true);
    });
  });
}
