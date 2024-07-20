import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testtrinity/domain/core/constants/color_constants.dart';

class TextStyleConstants {
  static TextStyle textBase = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.poppins().fontFamily,
    color: ColorConstants.black,
  );

  static TextStyle get defaultText => textBase;
  static TextStyle get appBarText =>
      defaultText.copyWith(fontWeight: FontWeight.w700, fontSize: 23.sp);
  static TextStyle get buttonText =>
      defaultText.copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp);
  static TextStyle get thinText =>
      defaultText.copyWith(fontWeight: FontWeight.w200);
}
