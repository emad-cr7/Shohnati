import 'package:flutter/material.dart';

class AppDialogs {
  static void showError(
    BuildContext context, {
    String title = 'Error',
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  static void showAlreadyRegistered(

    BuildContext context, {
    VoidCallback? onLoginPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('The account already exists.'),
        content: const Text(
          'Email or mobile number already registered. Please log in instead.',
        ),
        actions: [
          if (onLoginPressed != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onLoginPressed();
              },
              child: const Text('Log in'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }
}
