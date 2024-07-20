import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testtrinity/infrastructure/navigation/routes.dart';
import 'package:testtrinity/presentation/controllers/home/home_controller.dart';

class ContactDetailController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString name = ''.obs;
  RxString selectedDate = ''.obs;

  Map mapData = {};

  RxBool isFilled = false.obs;
  RxBool enableCreate = false.obs;

  HomeController cHome = Get.find();

  TextEditingController textControllerFirstName = TextEditingController();
  TextEditingController textControllerLastName = TextEditingController();
  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerDateOfBirth = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      if (args[0] == true) {
        enableCreate.value = args[0];
      } else {
        name.value = args[0];
        mapData = args[1];
      }
    }
    super.onInit();
  }

  void setFirstName({required String value}) {
    firstName.value = value;
    validateForm();
  }

  void setLastname({required String value}) {
    lastName.value = value;
    validateForm();
  }

  void setEmail({required String value}) {
    email.value = value;
  }

  void validateForm() {
    isFilled.value =
        isNotEmpty(data: firstName.value) && isNotEmpty(data: lastName.value);
  }

  bool validateEmptyFieldFirstName(String value) {
    return isNotEmpty(data: value);
  }

  bool validateEmptyFieldLastName(String value) {
    return isNotEmpty(data: value);
  }

  bool isNotEmpty({required String data}) {
    if (data.isEmpty) {
      return false;
    }
    return true;
  }

  bool validateEmail({required String value}) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return emailRegex.hasMatch(value) || value == '';
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String finalPick = DateFormat('dd/MM/yyyy').format(pickedDate).toString();
      selectedDate.value = finalPick.toString();
    }
  }

  void updateData() {
    if (isFilled.value == true) {
      name.value = '${firstName.value} ${lastName.value}';
      cHome.listData.firstWhere(
        (element) =>
            element["id"].toString().toLowerCase() ==
            mapData["id"].toString().toLowerCase(),
      )['firstName'] = firstName.value;
      cHome.listData.firstWhere(
        (element) =>
            element["id"].toString().toLowerCase() ==
            mapData["id"].toString().toLowerCase(),
      )['lastName'] = lastName.value;
      cHome.listData.firstWhere(
        (element) =>
            element["id"].toString().toLowerCase() ==
            mapData["id"].toString().toLowerCase(),
      )['email'] = email.value;
      cHome.listData.firstWhere(
        (element) =>
            element["id"].toString().toLowerCase() ==
            mapData["id"].toString().toLowerCase(),
      )['dob'] = selectedDate.value;

      Get.offNamed(Routes.HOME);
    } else {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      if (firstName.value.isEmpty) {
        setFirstName(value: '');
      }
      if (lastName.value.isEmpty) {
        setLastname(value: '');
      }
    }

    refresh();
  }

  void removeData() {
    cHome.listData.removeWhere(
      (element) =>
          element["id"].toString().toLowerCase() ==
          mapData["id"].toString().toLowerCase(),
    );
    Get.offNamed(Routes.HOME);

    refresh();
  }

  void saveData() {
    if (firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty &&
        email.value.isNotEmpty &&
        selectedDate.value.isNotEmpty) {
      cHome.listData.add({
        "firstName": firstName.value,
        "lastName": lastName.value,
        "email": email.value,
        "dob": selectedDate.value,
      });
    } else if (firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty &&
        email.value.isNotEmpty) {
      cHome.listData.add({
        "firstName": firstName.value,
        "lastName": lastName.value,
        "email": email.value,
      });
    } else if (firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty &&
        selectedDate.value.isNotEmpty) {
      cHome.listData.add({
        "firstName": firstName.value,
        "lastName": lastName.value,
        "dob": selectedDate.value,
      });
    } else {
      cHome.listData.add({
        "firstName": firstName.value,
        "lastName": lastName.value,
      });
    }
    Get.offNamed(Routes.HOME);
  }
}
