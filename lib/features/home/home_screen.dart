import 'package:flutter/material.dart';

import '../../core/data_source/shared_preferences/preferences_manager.dart';
import '../../core/shared/app_dialogs.dart';
import '../auth/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await PreferencesManager().setBool('isLoggedIn', false);
            await PreferencesManager().remove('token');
            AppDialogs.showInfo(
              context,
              message: 'You have been logged out',
              onOkPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              },
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Text('Logged in successfully', style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
