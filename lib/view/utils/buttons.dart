import 'package:flutter/material.dart';
import 'package:todo/Constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(this.onPressed, this.text);
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primaryColor),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(text, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  SecondaryButton(this.onPressed, this.text);
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xFFD0D1FF)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(width: 2, color: primaryColor)))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(text, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}
