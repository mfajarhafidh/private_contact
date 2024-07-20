import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/entities/data_json/data_json_model.dart';
import 'package:testtrinity/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  TextEditingController textControllerUserID = TextEditingController();

  RxString userID = ''.obs;

  void setUserID(String value) {
    userID.value = value;
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

  Future<void> postLogin() async {
    try {
      if (await DataJsonModel()
          .listDataJson
          .firstWhere(
            (element) => element["id"].toString().toLowerCase() == userID.value,
          )
          .isNotEmpty) {
        Get.offAllNamed(Routes.HOME);
      } else {
        throw Exception('Please Fill Correctly');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
