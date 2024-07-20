import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/entities/data_json/data_json_model.dart';
import 'package:testtrinity/infrastructure/data/data_sources/local/storage_local.dart';
import 'package:testtrinity/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  TextEditingController textControllerUserID = TextEditingController();

  RxString userID = ''.obs;

  @override
  Future<void> onInit() async {
    if (await StorageLocal().getString(StorageLocal.USER_ID) != '') {
      postLogin();
    }
    super.onInit();
  }

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
      if (userID.value.isNotEmpty) {
        await StorageLocal().setString(StorageLocal.USER_ID, userID.value);
      }
      if (await DataJsonModel()
          .listDataJson
          .firstWhere(
            (element) => element["id"].toString().toLowerCase() == userID.value,
          )
          .isNotEmpty) {
        Get.offAllNamed(Routes.HOME, arguments: [userID.value]);
      } else if (await StorageLocal().getString(StorageLocal.USER_ID) != '') {
        if (await DataJsonModel()
            .listDataJson
            .firstWhere(
              (element) =>
                  element["id"].toString().toLowerCase() ==
                  StorageLocal().getString(StorageLocal.USER_ID),
            )
            .isNotEmpty) {
          Get.offAllNamed(Routes.HOME,
              arguments: [StorageLocal().getString(StorageLocal.USER_ID)]);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
