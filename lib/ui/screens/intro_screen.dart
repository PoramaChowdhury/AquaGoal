import 'package:aquagoal/ui/screens/home_screen.dart';
import 'package:aquagoal/ui/screens/sign_in_screen.dart';
import 'package:aquagoal/ui/utils/app_colors.dart';
import 'package:aquagoal/ui/utils/assets_path.dart';
import 'package:aquagoal/ui/widgets/screen_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to AquaGoal!',
              style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // Image (Optional, you can uncomment it if you have the image)
            Image.asset(
              AssetsPath.welcome_image,
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 20),

            Text(
              'Join us to track your water intake and stay hydrated',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 50),
            RichText(
              text: TextSpan(
                text: "Ready to make a splash? ",
                style: GoogleFonts.italiana(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
                children: [
                  TextSpan(
                    text: 'Create your account now!',
                    style: GoogleFonts.italiana(
                      color: AppColors.themeColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    /*recognizer: TapGestureRecognizer()..onTap = () {
                      // Navigate to Sign Up screen or perform an action
                    },*/
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const SignInScreen(),
                  ),
                );
              },
              child: Text(
                'Sign In',
                style: GoogleFonts.italiana(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
