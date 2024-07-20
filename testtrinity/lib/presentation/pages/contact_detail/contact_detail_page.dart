import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/core/constants/assets_constants.dart';
import 'package:testtrinity/domain/core/constants/color_constants.dart';
import 'package:testtrinity/domain/core/constants/text_style_constants.dart';
import 'package:testtrinity/domain/core/utils/text_field_utils.dart';
import 'package:testtrinity/presentation/controllers/contact_detail/contact_detail_controller.dart';

class ContactDetailPage extends GetView<ContactDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: ColorConstants.white,
        toolbarHeight: kToolbarHeight + 20.h,
        centerTitle: false,
        backgroundColor: ColorConstants.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorConstants.black,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Contact Details',
            style: TextStyleConstants.appBarText,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
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
            47.verticalSpace,
            Text(
              'Main Information',
              style: TextStyleConstants.textBase.copyWith(
                  fontSize: 15.sp,
                  color: ColorConstants.blue,
                  fontStyle: FontStyle.italic),
            ),
            8.verticalSpace,
            Container(
              color: ColorConstants.darkGray,
              height: 1.h,
            ),
            10.verticalSpace,
            TextFieldUtils(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.w, top: 19.h, bottom: 19.h),
                child: SvgPicture.asset(
                  AssetsConstants.iconProfileSelected,
                ),
              ),
              requiredText: true,
              controller: controller.textControllerFirstName,
              label: 'First Name',
              hint: 'Enter first name..',
              onChanged: (value) => controller.setFirstName(value: value),
              validation: controller.validateEmptyField,
              keyboardType: TextInputType.text,
              validationText: 'Required. Please fill this',
              textInputAction: TextInputAction.next,
            ),
            TextFieldUtils(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.w, top: 19.h, bottom: 19.h),
                child: SvgPicture.asset(
                  AssetsConstants.iconProfileSelected,
                ),
              ),
              requiredText: true,
              controller: controller.textControllerLastName,
              label: 'Last Name',
              hint: 'Enter last name..',
              onChanged: (value) => controller.setLastname(value: value),
              validation: controller.validateEmptyField,
              keyboardType: TextInputType.text,
              validationText: 'Required. Please fill this',
              textInputAction: TextInputAction.done,
            ),
            47.verticalSpace,
            Text(
              'Sub Information',
              style: TextStyleConstants.textBase.copyWith(
                  fontSize: 15.sp,
                  color: ColorConstants.blue,
                  fontStyle: FontStyle.italic),
            ),
            8.verticalSpace,
            Container(
              color: ColorConstants.darkGray,
              height: 1.h,
            ),
            10.verticalSpace,
            TextFieldUtils(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.w, top: 19.h, bottom: 19.h),
                child: SvgPicture.asset(
                  AssetsConstants.iconEmail,
                ),
              ),
              controller: controller.textControllerEmail,
              label: 'Email',
              hint: 'Enter email..',
              onChanged: (value) => controller.setEmail(value: value),
              validation: (value) => controller.validateEmail(value: value),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validationText:
                  'Please use correct email format, example: example@gmail.com',
            ),
            TextFieldUtils(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.w, top: 19.h, bottom: 19.h),
                child: SvgPicture.asset(
                  AssetsConstants.iconBirthdate,
                ),
              ),
              controller: controller.textControllerDateOfBirth,
              label: 'Date of Birth',
              hint: 'Enter birthday..',
              onChanged: (value) => controller.setDateOfBirth(value: value),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
            ),
            169.verticalSpace,
            _buttonUpdate(),
            27.verticalSpace,
            _buttonRemove(),
          ],
        ),
      ),
    );
  }

  Widget _buttonUpdate() {
    return GestureDetector(
      child: Container(
        height: 53.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: ColorConstants.blue.withOpacity(0.2)),
        child: Center(
          child: Text(
            'Update',
            style: TextStyleConstants.buttonText,
          ),
        ),
      ),
    );
  }

  Widget _buttonRemove() {
    return GestureDetector(
      child: Container(
        height: 53.h,
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.red),
            borderRadius: BorderRadius.circular(15.r)),
        child: Center(
          child: Text(
            'Remove',
            style: TextStyleConstants.defaultText
                .copyWith(fontSize: 16.sp, color: ColorConstants.red),
          ),
        ),
      ),
    );
  }
}
