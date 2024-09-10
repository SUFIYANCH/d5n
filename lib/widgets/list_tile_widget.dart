import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? ontap;
  const ListTileWidget({
    super.key,
    required this.text,
    required this.icon,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}
