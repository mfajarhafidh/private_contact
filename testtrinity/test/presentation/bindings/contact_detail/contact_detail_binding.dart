import 'package:get/get.dart';
import 'package:testtrinity/presentation/controllers/contact_detail/contact_detail_controller.dart';

class ContactDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactDetailController());
  }
}
