import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class Utils{

  static showInSnackBar(BuildContext context, String value, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: duration ?? Duration(seconds: 2),
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary.withValues(alpha: 0.5),
        content: Center(
          child: Text(
            value,
            style: AppTextStyles.montserratRegular(14, color: AppColors.white),
          ),
        ))
    );
  }
}