import 'package:flutter/material.dart';

import 'core/graphL/zone_service.dart';
import 'core/theming/ThemeData.dart';
import 'features/auth/login/login_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'Sh7naty',
      home: LoginScreen(),
    );
  }
}
