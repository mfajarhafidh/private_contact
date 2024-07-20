import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/core/constants/assets_constants.dart';
import 'package:testtrinity/domain/core/constants/color_constants.dart';
import 'package:testtrinity/domain/core/constants/text_style_constants.dart';
import 'package:testtrinity/infrastructure/navigation/routes.dart';
import 'package:testtrinity/presentation/controllers/home/home_controller.dart';

class TabHome extends GetView<HomeController> {
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
            'My Contacts',
            style: TextStyleConstants.appBarText,
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(left: 26.w, right: 32.w),
          child: ListView(
            children: [
              18.verticalSpace,
              _textField(),
              25.verticalSpace,
              _gridContacts(),
              75.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField() {
    return Obx(
      () => TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        maxLines: 1,
        enabled: true,
        controller: controller.textEditingController,
        style: TextStyleConstants.defaultText,
        textAlignVertical: TextAlignVertical.center,
        decoration: controller.isFilled.value && controller.search.value != ''
            ? InputDecoration(
                labelStyle:
                    TextStyleConstants.thinText.copyWith(fontSize: 14.sp),
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(color: ColorConstants.darkGray)),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    AssetsConstants.iconSearchNotEmpty,
                  ),
                ))
            : InputDecoration(
                isDense: true,
                hintText: 'Search your contact list...',
                hintStyle: TextStyleConstants.thinText
                    .copyWith(fontSize: 14.sp, color: ColorConstants.darkGray),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(color: ColorConstants.darkGray)),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    AssetsConstants.iconSearch,
                  ),
                )),
        onChanged: (value) {
          controller.setSearch(value);
        },
      ),
    );
  }

  Widget _gridContacts() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 16.w,
      ),
      itemCount: controller.listSearch.isNotEmpty
          ? controller.listSearch.length
          : controller.listData.length,
      itemBuilder: (BuildContext context, int i) {
        return _itemGridContacts(
            contact: controller.listSearch.isNotEmpty
                ? controller.listSearch[i]
                : controller.listData[i],
            name: controller.listSearch.isNotEmpty
                ? '${controller.listSearch[i]['firstName']} ${controller.listSearch[i]['lastName']}'
                : '${controller.listData[i]['firstName']} ${controller.listData[i]['lastName']}');
      },
    );
  }

  Widget _itemGridContacts({required String name, required Map contact}) {
    return InkWell(
      onTap: () =>
          Get.toNamed(Routes.CONTACT_DETAIL, arguments: [name, contact]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: ColorConstants.darkGray),
        ),
        child: Column(
          children: [
            5.verticalSpace,
            Avatar(
              shape: AvatarShape.circle(40.r),
              border: Border.all(color: ColorConstants.darkGray),
              name: name,
              textStyle: TextStyleConstants.thinText
                  .copyWith(fontSize: 30.sp, color: ColorConstants.white),
              placeholderColors: [ColorConstants.blue],
            ),
            8.verticalSpace,
            Text(
              name,
              style: TextStyleConstants.defaultText,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
