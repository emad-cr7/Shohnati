import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../core/shared/app_dialogs.dart';
import '../../../../main.dart';
import '../../../home/home_screen.dart';
import '../../data/services/auth_service.dart';

class OtpController extends ChangeNotifier {
  final String email;
  OtpController({required this.email});

  final AuthService authService = AuthService();
  final TextEditingController otpController = TextEditingController();
  bool isVerifying = false;
  bool isResending = false;

  // ------------------------------verify--------------------------------

  Future<void> verify() async {
    final code = otpController.text.trim();
    final context = navigatorKey.currentContext;

    if (code.length != 4) {
      if (context != null) {
        AppDialogs.showError(context, message: 'Please enter the 4-digit code.');
      }
      return;
    }

    isVerifying = true;
    notifyListeners();

    try {
      final result = await authService.verifyRegistrationEmail(
        email: email,
        code: code,
      );

      if (result['token'] != null) {
        final ctx = navigatorKey.currentContext;
        if (ctx != null) {
          Navigator.pushAndRemoveUntil(
            ctx,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      log('Verify OTP Error: $e');
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        AppDialogs.showError(
          ctx,
          message: 'Invalid or expired code, please try again.',
        );
      }
    } finally {
      isVerifying = false;
      notifyListeners();
    }
  }

  // ------------------------------resend--------------------------------

  Future<void> resend() async {
    isResending = true;
    notifyListeners();

    try {
      await authService.resendVerificationCode(email);
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        AppDialogs.showSuccess(
          ctx,
          message: 'A new code has been sent to your email.',
        );
      }
    } catch (e) {
      log('Resend OTP Error: $e');
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        AppDialogs.showError(
          ctx,
          message: 'Could not resend the code, please try again.',
        );
      }
    } finally {
      isResending = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    otpController.dispose();
    super.dispose();
  }
}
