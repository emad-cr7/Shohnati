import 'package:flutter/material.dart';
import 'core/data_source/shared_preferences/preferences_manager.dart';
import 'core/theming/ThemeData.dart';
import 'features/auth/login/login_screen.dart';
import 'features/home/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final token = PreferencesManager().getString('token');

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'Sh7naty',
      home: token != null ? const HomeScreen() : LoginScreen(),
    );
  }
}
