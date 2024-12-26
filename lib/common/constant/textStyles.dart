
import 'package:flutter/cupertino.dart';
import '../theme/color/app_colors.dart';
class TextStyles {
  static const String fontFamily = "roboto";
  static const String arabicFontFamily = "Tajawal";

  // Bold TextStyles
  static TextStyle bold28({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily:  fontFamily,
        fontSize: 28,
        color: color ?? AppColors.black,
      );
  static TextStyle bold26({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily:  fontFamily,
        fontSize: 26,
        color: color ?? AppColors.black,
      );
  static TextStyle bold24({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily:  fontFamily,
        fontSize: 24,
        color: color ?? AppColors.black,
      );
  static TextStyle bold22({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily:  fontFamily,
        fontSize: 22,
        color: color ?? AppColors.black,
      );


  static TextStyle bold20({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily:  fontFamily,
        fontSize: 20,
        color: color ?? AppColors.black,
      );


  static TextStyle bold16({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily:  fontFamily,
        fontSize: 16,
        color: color ?? AppColors.black,
      );

  static String getFontFamily() =>  fontFamily;
}
