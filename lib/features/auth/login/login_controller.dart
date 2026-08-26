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