import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sh7naty/features/auth/login/login_screen.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/shared/app_dialogs.dart';
import '../../../../main.dart';


class OtpController extends ChangeNotifier {
  final String email;

  OtpController({required this.email}) {
    log('OTP Controller email: $email');
  }

  final AuthService authService = AuthService();
  final TextEditingController otpCodeController = TextEditingController();
  bool isVerifying = false;
  bool isResending = false;

  // ------------------------------resend cooldown--------------------------------

  static const int resendCooldownSeconds = 120;
  int resendSecondsLeft = 0;
  Timer? _resendTimer;

  bool get canResend => resendSecondsLeft == 0; //

  void startResendTimer() {
    resendSecondsLeft = resendCooldownSeconds;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSecondsLeft == 0) {
        timer.cancel();
        return;
      }
      resendSecondsLeft--;
      notifyListeners();
    });
  }

  // ------------------------------verify--------------------------------

  Future<void> verify() async {
    final code = otpCodeController.text.trim();
    final context = navigatorKey.currentContext;
    if (code.length != 4) {
      if (context != null) {
        AppDialogs.showError(
          context,
          message: 'Please enter the 4-digit code.',
        );
      }
      return;
    }

    isVerifying = true;
    notifyListeners();

    try {
      await authService.verifyRegistrationEmail(email: email, code: code);

      if (context != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      log('Verify OTP Error: $e');
      if (context != null) {
        AppDialogs.showError(context, message: e.toString());
      }
    } finally {
      isVerifying = false;
      notifyListeners();
    }
  }

  // ------------------------------resend--------------------------------

  Future<void> resend() async {
    if (!canResend) return;
    isResending = true;
    notifyListeners();

    try {
      await authService.resendVerificationCode(email);
      final context = navigatorKey.currentContext;
      if (context != null) {
        AppDialogs.showSuccess(
          context,
          message: 'A new code has been sent to your email.',
        );
      }
      startResendTimer();
    } catch (e) {
      log('Resend OTP Error: $e');
      final context = navigatorKey.currentContext;
      if (context != null) {
        AppDialogs.showError(
          context,
          message: 'Could not resend the code, please try again.',
        );
      }
    } finally {
      isResending = false;
      notifyListeners();
    }
  }

  // ------------------------------dispose--------------------------------

  @override
  void dispose() {
    _resendTimer?.cancel();
    otpCodeController.dispose();
    super.dispose();
  }
}
