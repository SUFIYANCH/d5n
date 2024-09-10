import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:d5n_interview/utils/snackbar.dart';
import 'package:d5n_interview/view/auth/sign_up_screen.dart';
import 'package:d5n_interview/widgets/button_widget.dart';
import 'package:d5n_interview/widgets/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  )),
              const Spacer(),
              Text(
                "Forgot Password",
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: R.rw(24, context)),
              ),
              const Spacer(),
              const Spacer()
            ],
          ),
          SizedBox(
            height: R.rw(24, context),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: R.rw(24, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextfieldWidget(
                    hinttext: "Email", textcontroller: emailController),
                SizedBox(height: R.rh(10, context)),
                Text(
                    "Enter the email address you used to create your account and we will email you a link to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        height: 2,
                        fontWeight: FontWeight.w500,
                        fontSize: R.rw(12, context))),
                SizedBox(height: R.rh(32, context)),
                ButtonWidget(
                    text: "CONTINUE",
                    onpressed: () async {
                      if (emailController.text.isEmpty) {
                        snackbar("Please fill all the fields", context);
                      } else {
                        await AuthService()
                            .forgotPassword(emailController.text);
                        Navigator.pop(context);
                        emailController.clear();
                        snackbar(
                            "Password reset link has been sent to your email",
                            context);
                      }
                    }),
                SizedBox(height: R.rh(32, context)),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          fontSize: R.rw(13, context),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Register',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()),
                                );
                              },
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
