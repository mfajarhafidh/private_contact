import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtrinity/presentation/controllers/home/home_controller.dart';
import 'package:testtrinity/presentation/pages/home/components/custom_bottom_navigation_bar.dart';
import 'package:testtrinity/presentation/pages/home/tabs/tab_home.dart';
import 'package:testtrinity/presentation/pages/home/tabs/tab_profile.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Obx(
          () => Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: (pageIndex) {
                  controller.selectedPage(pageIndex);
                },
                children: [
                  TabHome(),
                  TabProfile(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomNavigationBar(
                  selectedIndex: controller.selectedPage.value,
                  onTap: (pageIndex) {
                    controller.selectedPage(pageIndex);
                    controller.pageController
                        .jumpToPage(controller.selectedPage.value);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
