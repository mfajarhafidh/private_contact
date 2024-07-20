import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/core/constants/color_constants.dart';
import 'package:testtrinity/domain/core/constants/text_style_constants.dart';
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
      body: ListView(
        children: [],
      ),
    );
  }
}
