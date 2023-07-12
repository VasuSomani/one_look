import 'package:flutter/material.dart';
import 'package:todo/Constants/colors.dart';

class TaskCheckBox extends StatefulWidget {
  TaskCheckBox({Key? key}) : super(key: key);

  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      splashColor: Colors.white,
      child: Container(
        height: 32,
        width: 32,
        child: Image.asset('assets/icons/tasks.png',
            color: (_isChecked) ? (Color(0xFF58C6CD)) : null),
      ),
    );
  }
}
