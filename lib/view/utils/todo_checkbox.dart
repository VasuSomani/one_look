import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckBox extends StatefulWidget {
  CheckBox({Key? key, required this.isCompleted}) : super(key: key);
  final String isCompleted;
  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    final bool isChecked = bool.parse(widget.isCompleted);
    return (isChecked)
        ? Lottie.asset('assets/animations/completed.json', repeat: false)
        : Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFFB0B2C3), width: 1)),
            child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isChecked) ? (null) : (Colors.grey.shade100))),
          );
  }
}
