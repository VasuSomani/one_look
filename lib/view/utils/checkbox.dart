import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  CheckBox({Key? key}) : super(key: key);

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
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
      child: (_isChecked)
          ? (Icon(
              Icons.add_task_rounded,
              color: Color(0xFF58C6CD),
              size: 32,
            ))
          : Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFB0B2C3), width: 2)),
              child: Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_isChecked) ? (null) : (Color(0xFFF0F1F9)))),
            ),
    );
  }
}
