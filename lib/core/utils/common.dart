import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/core/config/themes/app_colors.dart';

class Common{
  static toastWarning(BuildContext context, String message, {Color? backgroundcolor, Color? textcolor}) {
    var snackBar = SnackBar(
      // action: SnackBarAction(
      //   label: "Ok",
      //   onPressed: () {},
      //   textColor: textcolor ?? Colors.white,
      // ),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(color: textcolor ?? Colors.white),
      ),
      backgroundColor: backgroundcolor ?? AppColors.red,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

}