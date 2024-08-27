import 'package:flutter/material.dart';

class ApplicitionThemeManager {
  static const Color primaryGreenColor = Color(0xFFDFECDB);
  static const Color primaryBlueColor = Color(0xFF5D9CEC);
  static const Color primaryBlueDarkColor = Color(0xFF060E1E);

  //#141922

  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryGreenColor,
      primaryColorLight: primaryBlueColor,
      scaffoldBackgroundColor: primaryGreenColor,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: Colors.white,
          )),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: Colors.white),
        bodyLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.black54,
        ),
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          color: Colors.black,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // backgroundColor: Colors.black
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          color: primaryBlueColor,
          fontSize: 18,
          fontFamily: "Poppins",
        ),
        selectedIconTheme: IconThemeData(
          size: 35,
          color: primaryBlueColor,
        ),
        unselectedIconTheme: IconThemeData(
          size: 30,
          color: Color(0xffc8c9cb),
        ),
      ));
  static ThemeData darkTheme = ThemeData(
      primaryColor: primaryBlueDarkColor,
      primaryColorLight: primaryBlueColor,
      scaffoldBackgroundColor: primaryBlueDarkColor,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: Colors.white,
          )),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: Colors.white),
        bodyLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // backgroundColor: Colors.white
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          color: primaryBlueColor,
          fontSize: 18,
          fontFamily: "Poppins",
        ),
        selectedIconTheme: IconThemeData(
          size: 35,
          color: primaryBlueColor,
        ),
        unselectedIconTheme: IconThemeData(
          size: 30,
          color: Color(0xffc8c9cb),
        ),
      ));
}
