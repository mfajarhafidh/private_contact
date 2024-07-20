import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/core/constants/assets_constants.dart';
import 'package:testtrinity/domain/core/constants/color_constants.dart';
import 'package:testtrinity/domain/core/constants/text_style_constants.dart';
import 'package:testtrinity/domain/core/utils/text_field_utils.dart';
import 'package:testtrinity/presentation/controllers/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView(
          children: [
            53.verticalSpace,
            Text(
              'Hi There!',
              style: TextStyleConstants.defaultText.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: ColorConstants.blue),
            ),
            5.verticalSpace,
            Text(
              'Please login to see your contact list',
              style: TextStyleConstants.defaultText
                  .copyWith(color: ColorConstants.darkGray),
            ),
            45.verticalSpace,
            TextFieldUtils(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.w, top: 19.h, bottom: 19.h),
                child: SvgPicture.asset(
                  AssetsConstants.iconProfileSelected,
                ),
              ),
              requiredText: true,
              controller: controller.textControllerUserID,
              label: 'User ID',
              hint: 'Enter your user ID..',
              onChanged: (value) => controller.setUserID(value),
              validation: controller.validateEmptyFieldFirstName,
              keyboardType: TextInputType.text,
              validationText: 'Required. Please fill this',
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buttonLogin(),
    );
  }

  Widget _buttonLogin() {
    return GestureDetector(
      // onTap: () =>,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 30.h),
        child: Container(
          height: 53.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: ColorConstants.blue.withOpacity(0.2)),
          child: Center(
            child: Text(
              'Login',
              style: TextStyleConstants.buttonText,
            ),
          ),
        ),
      ),
    );
  }
}
