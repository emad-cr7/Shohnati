import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/data_source/shared_preferences/preferences_manager.dart';
import '../../../core/shared/app_dialogs.dart';
import '../../../main.dart';
import '../../home/home_screen.dart';
import '../data/services/auth_service.dart';

class LoginController extends ChangeNotifier {
  final AuthService authService = AuthService();
  final PreferencesManager preferencesManager = PreferencesManager();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> Key = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool isLoading = false;

  Future<void> login() async {
    if (!Key.currentState!.validate()) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final result = await authService.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        rememberMe: true,
      );

      log('Login response: $result');

      final context = navigatorKey.currentContext;

      if (result != null && result['token'] != null) {
        if (context != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
          );
        }
      } else {
        if (context != null) {
          AppDialogs.showError(
            context,
            message: 'Login failed, please try again.',
          );
        }
      }
    } catch (e) {
      log('Login Error: $e');
      final context = navigatorKey.currentContext;
      if (context != null) {
        AppDialogs.showError(
          context,
          message: 'Invalid email or password.',
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
