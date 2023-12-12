import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TaskCheckBox extends StatefulWidget {
  TaskCheckBox({Key? key, required this.isCompleted}) : super(key: key);
  final String isCompleted;
  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = bool.parse(widget.isCompleted);
    return (isChecked)
        ? Lottie.asset('assets/animations/completed_primary.json',
            repeat: false)
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
