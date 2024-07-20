import 'package:get/get.dart';

import '../../presentation/pages.dart';
import '../../presentation/bindings/bindings.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
