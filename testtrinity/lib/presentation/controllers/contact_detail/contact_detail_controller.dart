import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString dateOfBirth = ''.obs;

  RxBool isFilled = false.obs;

  TextEditingController textControllerFirstName = TextEditingController();
  TextEditingController textControllerLastName = TextEditingController();
  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerDateOfBirth = TextEditingController();

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

  void setDateOfBirth({required String value}) {
    dateOfBirth.value = value;
  }

  void validateForm() {
    isFilled.value =
        isNotEmpty(data: firstName.value) && isNotEmpty(data: lastName.value);
  }

  bool validateEmptyField(String value) {
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
}
