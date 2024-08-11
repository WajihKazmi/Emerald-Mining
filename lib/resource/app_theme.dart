import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static ThemeData lightThemeData() => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      visualDensity: VisualDensity.standard,
      scaffoldBackgroundColor: const Color(0xFF221F3A),
      dividerTheme: const DividerThemeData(
        thickness: 2,
        space: 2,
        color: Color(0x7FDFA1ED),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF867890), //bg400
        primary: const Color(0xFF22B26D), //teal400
        onPrimary: Colors.white,
        primaryContainer: const Color(0x7FDFA1ED), //purple
        onPrimaryContainer: const Color(0xFF22533D), //bluegrey800
        surface: const Color(0xFF221F3A), //bg900
        onSurface: Color.fromARGB(255, 255, 255, 255),
        outline: const Color(0xff212121),
        
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
        headlineMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
        titleLarge: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        labelLarge: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
        labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
      ),
      
      );
}
