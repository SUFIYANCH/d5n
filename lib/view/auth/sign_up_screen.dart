import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/controller/user_service.dart';
import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:d5n_interview/utils/snackbar.dart';
import 'package:d5n_interview/view/auth/login_screen.dart';
import 'package:d5n_interview/view/home_screen.dart';
import 'package:d5n_interview/widgets/button_widget.dart';
import 'package:d5n_interview/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();

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
                "Create an Account",
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
                    hinttext: "Full Name", textcontroller: nameController),
                SizedBox(height: R.rh(20, context)),
                TextfieldWidget(
                    hinttext: "Email", textcontroller: emailController),
                SizedBox(height: R.rh(20, context)),
                TextfieldWidget(
                    hinttext: "Password", textcontroller: passwordController),
                SizedBox(height: R.rh(20, context)),
                TextfieldWidget(
                    hinttext: "Confirm Password",
                    textcontroller: confirmpasswordController),
                SizedBox(height: R.rh(32, context)),
                ButtonWidget(
                    text: "CONTINUE",
                    onpressed: () async {
                      try {
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmpasswordController.text.isEmpty) {
                          snackbar("Please fill all the fields", context);
                        } else {
                          if (passwordController.text !=
                              confirmpasswordController.text) {
                            snackbar(
                                "Password and confirm password do not match",
                                context);
                          } else {
                            UserCredential userCredential = await AuthService()
                                .signUp(emailController.text,
                                    passwordController.text);

                            if (userCredential.user != null) {
                              await UserService().addUser(
                                nameController.text,
                                emailController.text,
                                userCredential.user!.uid,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ));
                              snackbar("Account created successfully", context);
                            } else {
                              snackbar("Something went wrong", context);
                            }
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        snackbar(e.message.toString(), context);
                      }
                    }),
                SizedBox(height: R.rh(32, context)),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          fontSize: R.rw(13, context),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Log In',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
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
        ],
      ),
    );
  }
}
