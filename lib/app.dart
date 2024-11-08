import 'package:aquagoal/ui/screens/splash_screen.dart';
import 'package:aquagoal/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        ///by default ekta color set kore felbe
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      home: const SplashScreen(),
    );
  }


  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.withOpacity(0.7),
        // Slightly lighter color
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 6,
        // Slightly lower elevation for softer shadow
        side: BorderSide(color: Colors.indigo.withOpacity(0.2), width: 1),
        splashFactory: InkSplash.splashFactory,
        iconColor: Colors.white, // Ensure icon color is visible
      ),
    );
  }


  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: GoogleFonts.italiana(  // Use Google Fonts for hint style
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      fillColor: AppColors.fillColor,  // Use the custom fill color
      filled: true,
      border: _inputBorder(),
      enabledBorder: _enabledBorder(),
      focusedBorder: _focusedBorder(),
      errorBorder: _errorBorder(),
      focusedErrorBorder: _focusedErrorBorder(),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.enabledBorderColor, // Lighter color when enabled
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.focusedBorderColor, // Darker color when focused
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.errorBorderColor, // Red color when error occurs
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder _focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.errorBorderColor, // Red color when focused with error
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

}

