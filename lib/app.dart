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
        backgroundColor: Colors.lightBlueAccent.shade200,
        foregroundColor: Colors.white,
        /*padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),*/
        fixedSize: const Size.fromWidth(double.maxFinite),
        minimumSize: const Size(200, 50), // Button size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        elevation: 5.5,
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: GoogleFonts.italiana(
        fontWeight: FontWeight.w500,
        color: Colors.black45,
      ),
      fillColor: AppColors.fillColor,
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
        color: AppColors.enabledBorderColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.focusedBorderColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.errorBorderColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder _focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.errorBorderColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
