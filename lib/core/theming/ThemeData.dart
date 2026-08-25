import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    foregroundColor: Color(0xff00288E),
    elevation: 0,
    centerTitle: true,

    iconTheme: IconThemeData(
      color: Color(0xff00288E),
      size: 24,
    ),

    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xff3e3e42),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff00288E),
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,

    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xffE0E0E0),
        width: 1,
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xff00288E),
        width: 2,
      ),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),

    // TextFormField
    labelStyle: const TextStyle(
      color: Color(0xff757684),
      fontSize: 16,
    ),

    // Label بعد ما يطلع فوق
    floatingLabelStyle: const TextStyle(
      color: Color(0xff00288E),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),

    hintStyle: const TextStyle(
      color: Color(0xff999999),
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 40 ,
      color: Color(0xff00288E),
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Color(0xff3e3e42),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    displayLarge: TextStyle(
      color: Color(0xff3e3e42),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Color(0xff3e3e42),
      fontSize: 14,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    // titleLarge: TextStyle(
    //   color: Color(0xff6A6A6A),
    //   fontSize:  16,
    //   fontWeight: FontWeight.w400,
    //   decoration: TextDecoration.lineThrough,
    //   decorationColor: Color(0xff6A6A6A),
    //   overflow: TextOverflow.ellipsis,
    // ),
    // labelSmall: TextStyle(color: Color(0XFF161F1B), fontSize:  16),
    // labelMedium: TextStyle(color: Color(0XFF161F1B), fontSize:  24),
  ),

);
