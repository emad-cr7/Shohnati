import 'package:flutter/material.dart';

import '../../../core/sha/preferences_manager.dart';
import '../data/services/auth_service.dart';

class LoginController extends ChangeNotifier {
  final AuthService authService = AuthService();
  final PreferencesManager preferencesManager = PreferencesManager();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> Key = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool isLoading = false;

  Future<void> login() async {
    if (!Key.currentState!.validate()) {
      return;
    }

    try {
      final loginData = await authService.login(
        username: emailController.text.trim(),
        password: passwordController.text,
        rememberMe: true,
      );

      if (loginData != null) {
        final token = loginData['token'];

        if (token != null) {
          await preferencesManager.setString(
            'auth_token',
            token,
          );

          print('Token Saved: $token');
        }
      }
    } catch (e) {
      print('Login Error: $e');
    }
  }

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}