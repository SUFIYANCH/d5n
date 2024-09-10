import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onpressed;
  const ButtonWidget({
    super.key,
    required this.text,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF3E60AF),
            fixedSize: Size(R.maxWidth(context), R.rh(50, context)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(R.rw(2, context)))),
        onPressed: onpressed,
        child: Text(text));
  }
}
