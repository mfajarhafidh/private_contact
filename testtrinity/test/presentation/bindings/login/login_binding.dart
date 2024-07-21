import 'package:get/get.dart';
import 'package:testtrinity/presentation/controllers/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
