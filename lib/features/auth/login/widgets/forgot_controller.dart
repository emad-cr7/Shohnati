import 'package:flutter/material.dart';
import 'dart:developer';
import '../../../../core/services/auth_service.dart';
import '../../../../core/shared/app_dialogs.dart';
import '../../../../main.dart';

class ForgotController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> Key = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  bool isLoading = false;

  Future<void> resetPassword() async {
    if (!Key.currentState!.validate()) {
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      final result = await authService.resetPassword(
         emailController.text.trim(),
      );

      log('Reset Password response: $result');
      final context = navigatorKey.currentContext;

      if (result == true) {
        if (context != null) {
          Navigator.pop(context);
          AppDialogs.showSuccess(
            context,
            message: 'Password reset link sent to your email.',
          );
        }
      } else {
        if (context != null) {
          AppDialogs.showError(
            context,
            message: 'Reset password failed, please try again.',
          );
        }
      }
    } catch (e) {
      log('Reset Password Error: $e');

      final context = navigatorKey.currentContext;
      if (context != null) {
        AppDialogs.showError(
          context,
          message: 'Unable to reset your password. Please try again later.',
        );
      }
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
