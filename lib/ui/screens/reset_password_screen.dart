import 'package:aquagoal/data/models/network_response.dart';
import 'package:aquagoal/data/service/network_caller.dart';
import 'package:aquagoal/ui/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aquagoal/ui/screens/sign_in_screen.dart';
import 'package:aquagoal/ui/widgets/screen_background.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 84),
                Text(
                  'Set password',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    letterSpacing:
                        Theme.of(context).textTheme.displaySmall?.letterSpacing,
                    height: Theme.of(context).textTheme.displaySmall?.height,
                  )),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum password length should be 8 characters',
                  style: GoogleFonts.lato(
                      textStyle:
                          textTheme.titleSmall?.copyWith(color: Colors.grey)),
                ),
                const SizedBox(height: 23),
                _buildResetPasswordForm(),
                const SizedBox(height: 47),
                Center(child: _buildHaveAccountSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      children: [
        TextField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _confirmPasswordController,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(hintText: 'Confirm password'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: (Colors.black),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: 'Have account?  ',
        children: [
          TextSpan(
            text: 'Sign In ',
            style: const TextStyle(
              color: Colors.green,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showSnackBarMessage(context, 'Passwords do not match', true);
      return;
    }

    String email = widget.email;
    String otp = widget.otp;
    String newPassword = _passwordController.text;

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": newPassword,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: 'http://35.73.30.144:2005/api/v1/RecoverResetPassword/',
      body: requestBody,
    );

    if (response.isSuccess) {
      showSnackBarMessage(context, 'Password reset successful');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (_) => false,
      );
    } else {
      showSnackBarMessage(
          context, response.errorMessage ?? 'Failed to reset password', true);
    }
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (_) => false,
    );
  }
}
