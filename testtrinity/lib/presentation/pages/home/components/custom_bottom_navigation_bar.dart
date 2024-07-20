import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:testtrinity/domain/core/constants/assets_constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  final Function(int index) onTap;
  final int selectedIndex;

  Widget _itemMenu({
    required Function() onTap,
    required bool isSelected,
    required String icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 20.w,
        height: 20.h,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _itemMenu(
            onTap: () {
              onTap(0);
            },
            isSelected: selectedIndex == 0,
            icon: selectedIndex == 0
                ? AssetsConstants.iconHomeSelected
                : AssetsConstants.iconHome,
          ),
          _itemMenu(
            onTap: () {
              onTap(1);
            },
            isSelected: selectedIndex == 1,
            icon: selectedIndex == 1
                ? AssetsConstants.iconProfileSelected
                : AssetsConstants.iconProfile,
          ),
        ],
      ),
    );
  }
}
