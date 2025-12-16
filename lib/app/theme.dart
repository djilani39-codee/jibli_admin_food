import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryTextTheme: GoogleFonts.tajawalTextTheme(),
    textTheme: GoogleFonts.tajawalTextTheme(),
    iconTheme: const IconThemeData(
      color: dark,
    ),
    timePickerTheme: TimePickerThemeData(
      elevation: 0,
      dialHandColor: AppTheme.secondaryColor,
      dialBackgroundColor: AppTheme.lightRed,
      hourMinuteColor: AppTheme.lightRed,
      confirmButtonStyle: TextButton.styleFrom(
          backgroundColor: AppTheme.lightRed,
          foregroundColor: AppTheme.secondaryColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppTheme.lightRed,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppTheme.secondaryColor,
        selectionColor: AppTheme.secondaryColor,
        selectionHandleColor: AppTheme.secondaryColor),
    scaffoldBackgroundColor: primaryColor,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      centerTitle: true,
      titleTextStyle: GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: dark,

        // textStyle: const TextStyle(fontFamily: 'Inter'),
      ),
      color: primaryColor,
      elevation: 0,
    ),
    shadowColor: Colors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedIconTheme: IconThemeData(
        color: primaryColor,
      ),
      selectedIconTheme: IconThemeData(
        color: primaryColor,
      ),
      selectedItemColor: Color(0xffcecece),
      unselectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 14.0, color: primaryColor),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 13.0,
          color: Color(0xffcecece)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      hintStyle: TextStyle(
        color: const Color(0xff797979),
        fontSize: 13.dp,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Color(0xffcecece)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
            width: 1, color: Color.fromARGB(255, 233, 232, 232)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Color(0xffcecece)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: secondaryColor,
      // textStyle:
      //     GoogleFonts.notoKufiArabic(fontSize: 16.sp, color: primaryColor)
      // textStyle: const TextStyle(
      //   color: Colors.white,
      //   fontSize: 16,
      // ),
    )),
  );

  static const Color primaryColor = Colors.white;
  static const Color gray = Color(0xffBEBEBE);

  static const Color gray2 = Color(0xFF797979);
  static const Color secondaryColor = Color(0xffef2f55);
  static const Color seconderyColor2 = Color(0xFF2563EB);
  static const Color lightGreen = Color(0xffE0FFF0);
  static const Color lightRed = Color(0xffFFE0E0);
  static const Color lightBlue = Color(0xffE0FDFF);
  static const Color lightBlue2 = Color(0xFFDBEAFE);
  static const Color lightPurple = Color(0xFFDBEAFE);
  static const Color lightYellow = Color(0xffFFFCE0);
  static const Color dark = Color(0xFF242424);
}
