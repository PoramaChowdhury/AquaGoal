import 'package:aquagoal/ui/screens/home_screen.dart';
import 'package:aquagoal/ui/screens/sign_in_screen.dart';
import 'package:aquagoal/ui/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
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
              /*Image.asset(
                'assets/images/welcome_image.png',
                width: 250,
                height: 250,
              ),*/
              const SizedBox(height: 20),

              Text(
                'Join us to track your water intake and stay hydrated. Let\'s achieve your hydration goals together!',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Text(
                  'Continue',
                  style: GoogleFonts.italiana(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
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
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}