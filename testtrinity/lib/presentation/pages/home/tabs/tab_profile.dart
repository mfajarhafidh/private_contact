import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/core/constants/color_constants.dart';
import 'package:testtrinity/domain/core/constants/text_style_constants.dart';
import 'package:testtrinity/infrastructure/navigation/routes.dart';
import 'package:testtrinity/presentation/controllers/home/home_controller.dart';

class TabProfile extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: ColorConstants.white,
        toolbarHeight: kToolbarHeight + 20.h,
        centerTitle: false,
        backgroundColor: ColorConstants.white,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'My Profile',
            style: TextStyleConstants.appBarText,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w, top: 20.h),
            child: GestureDetector(
              onTap: () => controller.logout(),
              child: Text(
                'Logout',
                style: TextStyleConstants.buttonText,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 26.w, right: 32.w),
        child: ListView(
          children: [
            24.verticalSpace,
            Center(
              child: Avatar(
                shape: AvatarShape.circle(50.r),
                border: Border.all(color: ColorConstants.darkGray),
                name: controller.name.value,
                textStyle: TextStyleConstants.thinText
                    .copyWith(fontSize: 30.sp, color: ColorConstants.white),
                placeholderColors: [ColorConstants.blue],
              ),
            ),
            10.verticalSpace,
            Center(
              child: Text(
                controller.name.value,
                style: TextStyleConstants.defaultText.copyWith(fontSize: 15.sp),
              ),
            ),
            10.verticalSpace,
            Center(
              child: Text(
                controller.email.value,
                style: TextStyleConstants.defaultText.copyWith(fontSize: 15.sp),
              ),
            ),
            10.verticalSpace,
            Center(
              child: Text(
                controller.dateOfBirth.value,
                style: TextStyleConstants.defaultText.copyWith(fontSize: 15.sp),
              ),
            ),
            25.verticalSpace,
            _buttonUpdateDetail(),
          ],
        ),
      ),
    );
  }

  Widget _buttonUpdateDetail() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.CONTACT_DETAIL,
            arguments: [controller.name.value, controller.dataProfile, true]);
      },
      child: Container(
        height: 53.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: ColorConstants.blue.withValues(alpha: 0.2)),
        child: Center(
          child: Text(
            'Update my detail',
            style: TextStyleConstants.buttonText,
          ),
        ),
      ),
    );
  }
}
