import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/view/auth/login_screen.dart';
import 'package:d5n_interview/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthChecker extends ConsumerStatefulWidget {
  const AuthChecker({super.key});

  @override
  ConsumerState<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends ConsumerState<AuthChecker> {
  bool isLoggedIn = false;
  @override
  void initState() {
    ref.read(authServiceProvider).auth.currentUser != null
        ? setState(() {
            isLoggedIn = true;
          })
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}
