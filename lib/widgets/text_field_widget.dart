import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String hinttext;
  final TextEditingController textcontroller;
  final TextInputType? keyboardtype;

  const TextfieldWidget({
    super.key,
    required this.hinttext,
    required this.textcontroller,
    this.keyboardtype,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white12
                : Colors.black12),
      ),
      child: TextField(
          cursorColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
          controller: textcontroller,
          keyboardType: keyboardtype,
          decoration: InputDecoration(
              filled: true,
              hintText: hinttext,
              hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: R.rw(14, context),
                  fontWeight: FontWeight.w300),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(R.rw(4, context))))),
    );
  }
}
