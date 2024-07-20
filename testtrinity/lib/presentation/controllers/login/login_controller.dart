import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController textControllerUserID = TextEditingController();

  RxString userID = ''.obs;

  RxBool isFilled = false.obs;

  void setUserID(String value) {
    userID.value = value;
    isFilled.value = true;
  }

  bool validateEmptyFieldFirstName(String value) {
    return isNotEmpty(data: value);
  }

  bool isNotEmpty({required String data}) {
    if (data.isEmpty) {
      return false;
    }
    return true;
  }
}
