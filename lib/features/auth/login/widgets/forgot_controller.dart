import 'package:flutter/material.dart';

class ForgotController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final Key = GlobalKey<FormState>();


  void handleSubmit() {
    if (Key.currentState!.validate()) return;

  }

}