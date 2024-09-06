import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static ThemeData lightThemeData() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Nexa', // Use the new Nexa font family
        visualDensity: VisualDensity.standard,
        scaffoldBackgroundColor: const Color(0xFF221F3A),
        dividerTheme: const DividerThemeData(
          thickness: 2,
          space: 2,
          color: Color(0x7FDFA1ED),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF867890), // bg400
          primary: const Color.fromARGB(255, 42, 150, 100), // teal400
          onPrimary: Colors.white,
          primaryContainer: const Color(0x7FDFA1ED), // purple
          onPrimaryContainer:
              const Color.fromARGB(255, 27, 65, 48), // bluegrey800
          surface: const Color.fromARGB(255, 20, 17, 44), // bg900
          onSurface: Color.fromARGB(255, 255, 255, 255),
          outline: const Color(0xff212121),
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 25.sp,
            fontWeight:
                FontWeight.w600, // Could be mapped to Nexa Medium or similar
          ),
          headlineMedium: TextStyle(
            fontSize: 20.sp,
            fontWeight:
                FontWeight.w600, // Could be mapped to Nexa Medium or similar
          ),
          titleMedium: TextStyle(
            fontSize: 18.sp,
            fontWeight:
                FontWeight.w600, // Could be mapped to Nexa Medium or similar
          ),
          titleSmall: TextStyle(
            fontSize: 18.sp,
            fontWeight:
                FontWeight.w600, // Could be mapped to Nexa Regular or Book
          ),
          titleLarge: TextStyle(
            fontSize: 15.sp,
            fontWeight:
                FontWeight.w600, // Could be mapped to Nexa Bold or SemiBold
          ),
          labelMedium: TextStyle(
            fontSize: 15.sp,
            fontWeight:
                FontWeight.w600, // Could be mapped to Nexa Medium or similar
          ),
          labelLarge: TextStyle(
            fontSize: 15.sp,
            fontWeight:
                FontWeight.w600, // Could be mapped to Nexa Regular or Book
          ),
          labelSmall: TextStyle(
            fontSize: 10.sp,
            fontWeight:
                FontWeight.w500, // Could be mapped to Nexa Regular or Book
          ),
          bodyMedium: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
