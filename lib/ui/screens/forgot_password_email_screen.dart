// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:aquagoal/data/models/network_response.dart';
// import 'package:aquagoal/data/service/network_caller.dart';
// import 'package:aquagoal/data/utils/urls.dart';
// import 'package:aquagoal/ui/screens/forgot_password_otp_screen.dart';
// import 'package:aquagoal/ui/utils/app_colors.dart';
// import 'package:aquagoal/ui/widgets/centered_circular_progress_indicator.dart';
// import 'package:aquagoal/ui/widgets/screen_background.dart';
// import 'package:aquagoal/ui/widgets/snack_bar_message.dart';
//
// class ForgotPasswordEmailScreen extends StatefulWidget {
//   const ForgotPasswordEmailScreen({super.key});
//
//   @override
//   State<ForgotPasswordEmailScreen> createState() =>
//       _ForgotPasswordEmailScreenState();
// }
//
// class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
//   final TextEditingController _emailTEController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   bool _inProgress = false;
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ScreenBackground(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 82),
//                 Text(
//                   'Your Email Address',
//                   style: textTheme.titleLarge
//                       ?.copyWith(fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'A 6 digit verification otp will be sent to your email address',
//                   style: textTheme.titleSmall?.copyWith(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 24),
//                 _buildVerifyEmailForm(),
//                 const SizedBox(height: 24),
//                 Center(child: _buildHaveAccountSection()),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVerifyEmailForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             controller: _emailTEController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(hintText: 'Email'),
//           ),
//           const SizedBox(height: 8),
//           Visibility(
//             visible: !_inProgress,
//             replacement: const CenteredCircularProgressIndicator(),
//             child: ElevatedButton(
//               onPressed: _onTapNextButton,
//               child: const Icon(Icons.arrow_circle_right_outlined),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHaveAccountSection() {
//     return RichText(
//       text: TextSpan(
//         text: "Have an account? ",
//         style: const TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//           letterSpacing: 0.5,
//         ),
//         children: [
//           TextSpan(
//             text: 'Sign In',
//             style: const TextStyle(color: AppColors.themeColor),
//             recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onTapNextButton() {
//     if (_formKey.currentState!.validate()) {
//       _recoverEmailPassword();
//     }
//   }
//
//   Future<void> _recoverEmailPassword() async {
//     _inProgress = true;
//     setState(() {});
//     String email = _emailTEController.text.trim();
//
//     if (email.isEmpty) {
//       showSnackBarMessage(
//           context, 'Please provide a valid email address', true);
//
//       return;
//     }
//     final url = '${Urls.recoverPasswordEmail}$email';
//
//     NetworkResponse response = await NetworkCaller.getRequest(url: url);
//
//     _inProgress = false;
//     setState(() {});
//
//     if (response.isSuccess) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (ctx) => const ForgotPasswordOtpScreen(
//                   email: '',
//                 )),
//       );
//     } else {
//       showSnackBarMessage(context, response.errorMessage, true);
//     }
//   }
//
//   void _onTapSignIn() {
//     Navigator.pop(context);
//   }
// }

import 'package:aquagoal/data/models/network_response.dart';
import 'package:aquagoal/data/service/network_caller.dart';
import 'package:aquagoal/data/utils/urls.dart';
import 'package:aquagoal/ui/screens/forgot_password_otp_screen.dart';
import 'package:aquagoal/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:aquagoal/ui/widgets/screen_background.dart';
import 'package:aquagoal/ui/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  bool _forgetPasswordInProgress = false;
  final TextEditingController _emailController = TextEditingController();

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
                  'Enter Your Email',
                  style: GoogleFonts.montserrat(
                    textStyle: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
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
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: !_forgetPasswordInProgress,
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
              color: Colors.green,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    String email = _emailController.text.trim();

    // Validate the email format
    if (email.isEmpty) {
      showSnackBarMessage(context, 'Please enter a valid email address', true);
      return;
    }

    await _sendEmailVerificationRequest(email);
  }

  Future<void> _sendEmailVerificationRequest(String email) async {
    _forgetPasswordInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverEmail(email),
    );
    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotPasswordOtpScreen(
                  email: email,
                )),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _forgetPasswordInProgress = false;
    setState(() {});
  }

/* void _onTapNextButton() {

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgotPasswordOTPScreen()));

  }*/

  void _onTapSignIn() {
    Navigator.pop(context);
  }
}
