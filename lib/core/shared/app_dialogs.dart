import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static void showError(
      BuildContext context, {
        String title = 'Error',
        required String message,
      }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: message,
      btnOkText: 'OK',
      btnOkOnPress: () {},
    ).show();
  }

  static void showAlreadyRegistered(
      BuildContext context, {
        VoidCallback? onLoginPressed,
      }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: 'The account already exists.',
      desc:
      'Email or mobile number already registered. Please log in instead.',
      btnOkText: 'OK',
      btnOkOnPress: () {},
      btnCancelText: onLoginPressed != null ? 'Log in' : null,
      btnCancelOnPress: onLoginPressed,
    ).show();
  }
}