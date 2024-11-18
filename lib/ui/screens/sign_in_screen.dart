import 'package:aquagoal/ui/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aquagoal/data/models/login_model.dart';
import 'package:aquagoal/data/models/network_response.dart';
import 'package:aquagoal/data/service/network_caller.dart';
import 'package:aquagoal/data/utils/urls.dart';
import 'package:aquagoal/ui/controllers/auth_controller.dart';
import 'package:aquagoal/ui/screens/forgot_password_email_screen.dart';
import 'package:aquagoal/ui/screens/sign_up_screen.dart';
import 'package:aquagoal/ui/utils/app_colors.dart';
import 'package:aquagoal/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:aquagoal/ui/widgets/screen_background.dart';
import 'package:aquagoal/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inProgress = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ScreenBackground(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 82),
              Text(
                'Unlock Your Journey',
                style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              _buildSignInForm(),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          _onTapForgotPasswordButton();
                        },
                        child: Text(
                          'Forget Password!',
                          style: GoogleFonts.italiana(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.teal.shade700,
                          ),
                        )),
                    _buildSignUpSection(),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordTEController,
            obscureText: _obscureText,

            ///hiding password
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a your password';
              }
              if (value!.length <= 6) {
                return 'Enter a password more than 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Visibility(
            visible: !_inProgress,
            replacement: const CenteredCircularProgressIndicator(),
            child: ElevatedButton(
                onPressed: _onTapNextButton,
                child: Text(
                  'Sign In',
                  style: GoogleFonts.italiana(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
        text: TextSpan(
            text: "Don't have an account? ",
            style: GoogleFonts.italiana(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
            children: [
          TextSpan(
              text: 'Sign Up',
              style: GoogleFonts.italiana(
                color: AppColors.themeColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp),
        ]));
  }

  void _onTapNextButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _signIn();
  }

  Future<void> _signIn() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      'email': _emailTEController.text.trim(),
      'password': _passwordTEController.text,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);

      await AuthController.saveAccessToken(
          loginModel.token!); //TODO: why use 'token!' check
      await AuthController.saveUserData(loginModel.data!);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (value) => false,
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const ForgotPasswordEmailScreen(),
      ),
    );
    ;
  }

  void _onTapSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
}
