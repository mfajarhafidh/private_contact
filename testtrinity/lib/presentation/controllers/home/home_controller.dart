import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedPage = 0.obs;

  RxString search = ''.obs;

  RxBool isFilled = false.obs;

  late PageController pageController;
  TextEditingController textEditingController = TextEditingController();

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
    }
  }
}
