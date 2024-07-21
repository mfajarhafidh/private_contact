import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/entities/data_json/data_json_model.dart';
import 'package:testtrinity/infrastructure/data/data_sources/local/storage_local.dart';
import 'package:testtrinity/infrastructure/navigation/routes.dart';

class HomeController extends GetxController {
  RxInt selectedPage = 0.obs;

  RxString search = ''.obs;
  RxString userID = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString dateOfBirth = ''.obs;

  RxBool isFilled = false.obs;
  RxBool enableFlag = false.obs;

  late PageController pageController;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Map dataProfile = {};

  RxList listSearch = [].obs;

  RxList listData = [
    {
      "id": "5c8a80f52dfee238898d64cf",
      "firstName": "Phoebe",
      "lastName": "Monroe",
      "email": "phoebemonroe@furnafix.com",
      "dob": "3/2/1982"
    },
    {
      "id": "5c8a80f575270ddb54a18f86",
      "firstName": "Lidia",
      "lastName": "Wilkins",
      "email": "lidiawilkins@furnafix.com",
      "dob": "30/1/1962"
    },
    {
      "id": "5c8a80f57a27f272ab4272f9",
      "firstName": "Gertrude",
      "lastName": "Mccormick",
      "email": "gertrudemccormick@furnafix.com"
    },
    {
      "id": "5c8a80f5e2ad4c1edc5cc5d9",
      "firstName": "Maxine",
      "lastName": "Brady",
      "email": "maxinebrady@furnafix.com",
      "dob": "9/7/1987"
    },
    {
      "id": "5c8a80f5437a24a66ac7e0c5",
      "firstName": "Willie",
      "lastName": "Gonzalez",
      "dob": "6/12/1990"
    },
    {
      "id": "5c8a80f5a7d3d251ba82df41",
      "firstName": "Oliver",
      "lastName": "Floyd",
      "email": "oliverfloyd@furnafix.com",
      "dob": "18/4/1993"
    },
    {
      "id": "5c8a80f5d3c01af26b266b13",
      "firstName": "Elliott",
      "lastName": "Fry",
      "email": "elliottfry@furnafix.com",
      "dob": "19/7/1980"
    },
    {
      "id": "5c8a80f597cdf9c2fc4f8466",
      "firstName": "Hancock",
      "lastName": "Foreman"
    },
    {
      "id": "5c8a80f537cded38d718ecf5",
      "firstName": "Hood",
      "lastName": "Kline",
      "email": "hoodkline@furnafix.com",
      "dob": "2/6/1979"
    },
    {
      "id": "5c8a80f531ed87bee8d951d6",
      "firstName": "Adams",
      "lastName": "Phelps",
      "email": "adamsphelps@furnafix.com",
      "dob": "19/11/1984"
    },
    {
      "id": "5c8a80f537a8602ee2be6b6d",
      "firstName": "Ramos",
      "lastName": "Nieves",
      "email": "ramosnieves@furnafix.com",
      "dob": "16/5/1985"
    },
    {
      "id": "5c8a80f57ba5cd82a37a039c",
      "firstName": "White",
      "lastName": "Marsh",
      "email": "whitemarsh@furnafix.com",
      "dob": "23/8/1982"
    },
    {
      "id": "5c8a80f5d502bbf9f69e8b6d",
      "firstName": "Concepcion",
      "lastName": "Crane",
      "email": "concepcioncrane@furnafix.com",
      "dob": "28/1/1994"
    },
    {
      "id": "5c8a80f5000661cb7e325e17",
      "firstName": "Rhonda",
      "lastName": "Mckinney",
      "email": "rhondamckinney@furnafix.com",
      "dob": "3/2/1982"
    },
    {
      "id": "5c8a80f59283e24a4e526335",
      "firstName": "Hilda",
      "lastName": "Holder"
    },
    {
      "id": "5c8a80f52aec26a5edc4e17c",
      "firstName": "Burks",
      "lastName": "Aguilar",
      "email": "burksaguilar@furnafix.com",
      "dob": "3/2/1982"
    },
    {
      "id": "5c8a80f5b3a1e477360db964",
      "firstName": "Lorene",
      "lastName": "Stewart",
      "email": "lorenestewart@furnafix.com",
      "dob": "3/2/1982"
    },
    {
      "id": "5c8a80f57dab375acf5030c1",
      "firstName": "Susana",
      "lastName": "Short",
      "email": "susanashort@furnafix.com",
      "dob": "3/2/1982"
    },
    {
      "id": "5c8a80f523e488dd917a6e45",
      "firstName": "Lawson",
      "lastName": "French",
      "email": "lawsonfrench@furnafix.com",
      "dob": "3/2/1982"
    },
    {
      "id": "5c8a80f5e3d1f2f2967c4621",
      "firstName": "Paula",
      "lastName": "Turner",
      "email": "paulaturner@furnafix.com",
      "dob": "3/2/1982"
    }
  ].obs;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      userID.value = args[0];
    }
    flagText();
    pageController = PageController(initialPage: 0);
    profileData();
  }

  Future<void> onRefresh() async {
    listData.value = DataJsonModel().listDataJson;
    await Future.delayed(Duration(milliseconds: 500));
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
    listSearch.retainWhere(
      (p0) =>
          '${p0['firstName']} ${p0['lastName']}'.toLowerCase().contains(value),
    );
  }

  void flagText() {
    if (listData
        .firstWhere(
          (element) => element["id"].toString().toLowerCase() == userID.value,
        )
        .toString()
        .isNotEmpty) {
      enableFlag.value = true;
    }
  }

  void profileData() {
    dataProfile = listData.firstWhere(
      (element) => element["id"].toString().toLowerCase() == userID.value,
    );
    name.value = '${dataProfile['firstName']} ${dataProfile['lastName']}';
    email.value = '${dataProfile['email']}';
    dateOfBirth.value = '${dataProfile['dob']}';
  }

  Future<void> logout() async {
    await StorageLocal()
        .storageSharedPreferenceDelete(key: StorageLocal.USER_ID);
    Get.offAllNamed(Routes.LOGIN);
  }
}
