import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black38,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
      headline2: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(35),
      filled: true,
      fillColor: Color.fromRGBO(255, 255, 255, 0.1),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
    ),
  );
}
