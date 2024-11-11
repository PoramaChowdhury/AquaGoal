// import 'package:aquagoal/data/models/network_response.dart';
// import 'package:aquagoal/data/service/network_caller.dart';
// import 'package:aquagoal/data/utils/urls.dart';
// import 'package:aquagoal/ui/widgets/centered_circular_progress_indicator.dart';
// import 'package:aquagoal/ui/widgets/snack_bar_message.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:aquagoal/ui/screens/reset_password_screen.dart';
// import 'package:aquagoal/ui/screens/sign_in_screen.dart';
// import 'package:aquagoal/ui/utils/app_colors.dart';
// import 'package:aquagoal/ui/widgets/screen_background.dart';
//
// class ForgotPasswordOtpScreen extends StatefulWidget {
//   final String email; // Email passed from previous screen
//
//   const ForgotPasswordOtpScreen({super.key, required this.email});
//
//   @override
//   State<ForgotPasswordOtpScreen> createState() =>
//       _ForgotPasswordOtpScreenState();
// }
//
// class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _pinTEController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       //  resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: ScreenBackground(
//             child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 82),
//               Text(
//                 'Pin Verification',
//                 style:
//                     textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'A 6 digit verification otp has been sent to your email address',
//                 style: textTheme.titleSmall?.copyWith(
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               _buildResetPasswordForm(),
//               const SizedBox(height: 24),
//               Center(
//                 child: _buildHaveAccountSection(),
//               )
//             ],
//           ),
//         )),
//       ),
//     );
//   }
//
//   Widget _buildResetPasswordForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           PinCodeTextField(
//             controller: _pinTEController,
//             length: 6,
//             // obscureText: false, ///by default
//             animationType: AnimationType.fade,
//             keyboardType: TextInputType.number,
//             pinTheme: PinTheme(
//               shape: PinCodeFieldShape.box,
//               borderRadius: BorderRadius.circular(5),
//               fieldHeight: 50,
//               fieldWidth: 40,
//               activeFillColor: Colors.white,
//               inactiveFillColor: Colors.white,
//               selectedFillColor: Colors.white,
//             ),
//             animationDuration: Duration(milliseconds: 300),
//             backgroundColor: Colors.transparent,
//             enableActiveFill: true,
//             appContext: context,
//           ),
//           const SizedBox(height: 8),
//           Visibility(
//             visible: !_isLoading,
//             replacement: const CenteredCircularProgressIndicator(),
//             child: ElevatedButton(
//                 onPressed: () {
//                   _onTapNextButton();
//                 },
//                 child: const Icon(Icons.arrow_circle_right_outlined)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHaveAccountSection() {
//     return RichText(
//         text: TextSpan(
//             text: "Have an account? ",
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//               letterSpacing: 0.5,
//             ),
//             children: [
//           TextSpan(
//             text: 'Sign In',
//             style: const TextStyle(
//               color: AppColors.themeColor,
//             ),
//             recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
//           )
//         ]));
//   }
//
//   void _onTapNextButton() {
//     if (_formKey.currentState!.validate()) {
//       _verifyOtp();
//     }
//   }
//   Future<void> _verifyOtp() async {
//     _isLoading = true;
//     setState(() {
//     });
//
//     String email = widget.email;// Replace with the actual email
//     String otp = _pinTEController.text.trim();
//
//     if (email.isEmpty) {
//       showSnackBarMessage(
//           context, 'Please provide a valid email address', true);
//
//       return;
//     }
//
//     NetworkResponse response = await NetworkCaller.getRequest(url: Urls.recoverOTP(email, otp));
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     if (response.isSuccess) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (ctx) => const ResetPasswordScreen(email: '', otp: '',),
//         ),
//       );
//     } else {
//       showSnackBarMessage(context, response.errorMessage, true);
//     }
//   }
//
//   void _onTapSignIn() {
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (ctx) => const SignInScreen(),
//         ),
//         (_) => false);
//   }
// }

import 'package:aquagoal/data/models/network_response.dart';
import 'package:aquagoal/data/service/network_caller.dart';
import 'package:aquagoal/data/utils/urls.dart';
import 'package:aquagoal/ui/screens/reset_password_screen.dart';
import 'package:aquagoal/ui/screens/sign_in_screen.dart';
import 'package:aquagoal/ui/utils/app_colors.dart';
import 'package:aquagoal/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:aquagoal/ui/widgets/screen_background.dart';
import 'package:aquagoal/ui/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  final String email;

  const ForgotPasswordOtpScreen({super.key, required this.email});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  bool _forgetPasswordOtpInProgress = false;
  final TextEditingController _otpController = TextEditingController();

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
                const SizedBox(
                  height: 84,
                ),
                Text(
                  'Pin Verification  ',
                  style: GoogleFonts.montserrat(
                    textStyle: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'A 6 digit verification otp will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 23,
                ),
                _buildVerifyEmail(),
                const SizedBox(
                  height: 47,
                ),
                Center(child: _buildHaveAccountSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyEmail() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _otpController,
          length: 6,
          obscureText: false,
          keyboardType: TextInputType.number,
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: !_forgetPasswordOtpInProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapNextButton,
            child: const Text(
              'Continue',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
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
        text: 'Have account ?  ',
        children: [
          TextSpan(
            text: 'Sign In ',
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  // void _onTapNextButton() {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
  // }

  void _onTapNextButton() async {
    String otp = _otpController.text.trim();
    String email = widget.email;

    if (otp.isEmpty || otp.length != 6) {
      showSnackBarMessage(context, 'Please enter a valid 6-digit OTP', true);
      return;
    }

    await _verifyOTP(email, otp);
  }

  Future<void> _verifyOTP(String email, String otp) async {
    setState(() {
      _forgetPasswordOtpInProgress = true;
    });

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.otpEmail(email, otp),
    );

    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: email, otp: otp)),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    setState(() {
      _forgetPasswordOtpInProgress = false;
    });
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }
}
