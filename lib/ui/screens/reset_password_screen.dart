import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aquagoal/ui/screens/forgot_password_otp_screen.dart';
import 'package:aquagoal/ui/screens/sign_in_screen.dart';
import 'package:aquagoal/ui/utils/app_colors.dart';
import 'package:aquagoal/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenBackground(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 82),
              Text(
                'Set Password',
                style:
                    textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                'Minimum number of password should be 8 letters',
                style: textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              _buildVerifyEmailForm(),
              const SizedBox(height: 24),
              Center(
                child: _buildHaveAccountSection(),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildVerifyEmailForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(hintText: 'Confirm Password'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
            onPressed: () {
              _onTapNextButton();
            },
            child: const Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
        text: TextSpan(
            text: "Have an account? ",
            style: GoogleFonts.italiana(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
            children: [
          TextSpan(
            text: 'Sign In',
            style: GoogleFonts.italiana(
              color: AppColors.themeColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          )
        ]));
  }

  void _onTapNextButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }
}
