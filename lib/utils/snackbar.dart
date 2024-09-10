import 'package:flutter/material.dart';

void snackbar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black),
      ),
    ),
  );
}

void progressbar(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Color(0xff98c1d9),
      ),
    ),
  );
}
