import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles{

  static TextStyle montserratBold(double size, {Color color = AppColors.white}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: "MontserratBold"
    );
  }

  static TextStyle montserratMedium(double size, {Color color = AppColors.white}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        fontFamily: "MontserratMedium"
    );
  }

  static TextStyle montserratRegular(double size, {Color color = AppColors.white}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontFamily: "MontserratRegular"
    );
  }

}

class AppInputDecorationStyles{

  static InputDecoration formFieldDecoration(String hintText, double borderRadius){
    return InputDecoration(
        hintText: hintText,
        counterText: "",
        hintStyle: AppTextStyles.montserratRegular(13, color: AppColors.containerBorder),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.containerBorder
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        )
    );
  }
}