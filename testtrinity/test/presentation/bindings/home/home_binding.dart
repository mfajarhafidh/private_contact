import 'package:get/get.dart';
import 'package:testtrinity/presentation/controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
