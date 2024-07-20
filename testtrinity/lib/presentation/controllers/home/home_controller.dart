import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/entities/data_json/data_json_model.dart';

class HomeController extends GetxController {
  RxInt selectedPage = 0.obs;

  RxString search = ''.obs;

  RxBool isFilled = false.obs;

  late PageController pageController;
  TextEditingController textEditingController = TextEditingController();

  RxList listData = DataJsonModel().listDataJson.obs;
  RxList listSearch = [].obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  void setSearch(String value) {
    isFilled.value = true;
    search.value = value;
    if (search.value == '') {
      isFilled.value = false;
      listSearch.clear();
      listData.value = DataJsonModel().listDataJson;
    }
    postSearch(search.value);
  }

  void postSearch(String value) {
    listSearch(listData);
    listSearch.retainWhere((p0) {
      return '${p0['firstName']}${p0['lastName']}'
          .toLowerCase()
          .contains(value.toLowerCase());
    });
  }
}
