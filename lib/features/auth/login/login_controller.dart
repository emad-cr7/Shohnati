import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> Key = GlobalKey<FormState>();
  bool obscurePassword = true;

  Future<void> login() async {
    if (Key.currentState!.validate()) {
      print("don");
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
