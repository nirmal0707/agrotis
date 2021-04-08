import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FontType { BOLD, SEMI_BOLD, MEDIUM, REGULAR, LIGHT }

class AppTextStyles {
  static FontWeight fontType(FontType fontType) {
    switch (fontType) {
      case FontType.BOLD:
        return FontWeight.w700;
      case FontType.SEMI_BOLD:
        return FontWeight.w600;
      case FontType.MEDIUM:
        return FontWeight.w500;
      case FontType.REGULAR:
        return FontWeight.w400;
      case FontType.LIGHT:
        return FontWeight.w300;
      default:
        return FontWeight.w400;
    }
  }

  static TextStyle textStyle({
    FontType fontType,
    Color color = Colors.black,
    double size,
  }) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: AppTextStyles.fontType(fontType),
    );
  }

  static TextStyle s0({Color color}) => AppTextStyles.textStyle(
        size: 18.sp,
        color: color,
        fontType: FontType.LIGHT,
      );

  static TextStyle s1({Color color}) => AppTextStyles.textStyle(
        size: 24.sp,
        color: color,
        fontType: FontType.REGULAR,
      );

  static TextStyle s2({Color color}) => AppTextStyles.textStyle(
        size: 28.sp,
        color: color,
        fontType: FontType.REGULAR,
      );

  static TextStyle s3({Color color}) => AppTextStyles.textStyle(
        size: 28.sp,
        color: color,
        fontType: FontType.MEDIUM,
      );

  static TextStyle s4({Color color}) => AppTextStyles.textStyle(
        size: 38.sp,
        color: color,
        fontType: FontType.REGULAR,
      );
}
