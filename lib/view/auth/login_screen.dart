import 'dart:developer';

import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:d5n_interview/utils/snackbar.dart';
import 'package:d5n_interview/view/auth/forgot_password_screen.dart';
import 'package:d5n_interview/view/auth/sign_up_screen.dart';
import 'package:d5n_interview/view/home_screen.dart';
import 'package:d5n_interview/widgets/button_widget.dart';
import 'package:d5n_interview/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: R.rw(24, context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/loginimg.png",
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            SizedBox(height: R.rh(70, context)),
            TextfieldWidget(hinttext: "Email", textcontroller: emailController),
            SizedBox(height: R.rh(20, context)),
            TextfieldWidget(
                hinttext: "Password", textcontroller: passwordController),
            SizedBox(height: R.rw(8, context)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen()),
                );
              },
              child: Text("Forgot Password?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  )),
            ),
            SizedBox(height: R.rh(30, context)),
            ButtonWidget(
                text: "CONTINUE",
                onpressed: () async {
                  try {
                    if (emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      snackbar("Please fill all the fields", context);
                    } else {
                      await AuthService()
                          .login(emailController.text, passwordController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  } on FirebaseAuthException catch (e) {
                    snackbar("Something Went Wrong", context);
                    log(e.message.toString());
                  }
                }),
            SizedBox(height: R.rh(30, context)),
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
                                  builder: (context) => const SignupScreen()),
                            );
                          },
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
