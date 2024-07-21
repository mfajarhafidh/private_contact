import 'package:get/get.dart';
import 'package:testtrinity/presentation/bindings/bindings.dart';
import 'package:testtrinity/presentation/pages.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CONTACT_DETAIL,
      page: () => ContactDetailPage(),
      binding: ContactDetailBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
