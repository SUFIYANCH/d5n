import 'package:d5n_interview/view/auth/auth_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then(
      (value) {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthChecker(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/loginimg.png",
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
