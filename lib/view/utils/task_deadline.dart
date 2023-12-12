import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Constants/colors.dart';

DateTime? deadlineDate;
TimeOfDay? deadlineTime;

class TaskDeadline extends StatefulWidget {
  TaskDeadline({Key? key, required this.setDateTime}) : super(key: key);
  final Function(DateTime? deadlineDate, TimeOfDay? deadlineTime) setDateTime;
  @override
  State<TaskDeadline> createState() => _TaskDeadlineState();
}

class _TaskDeadlineState extends State<TaskDeadline> {
  void deadlineSelector(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 180)))
        .then((value) {
      deadlineDate = value;
      showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((value) {
        setState(() {
          deadlineTime = value;
          widget.setDateTime(deadlineDate, deadlineTime);
        });
      });
    });
  }

  @override
  void dispose() {
    deadlineDate = null;
    deadlineTime = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter1 = DateFormat('dd/MM/yyyy');
    final DateFormat formatter2 = DateFormat('h:mm a');
    bool timeOver = (deadlineTime == null)
        ? (false)
        : ((deadlineTime?.minute)! - (DateTime.now().minute) < 0);

    return InkWell(
      onTap: () => deadlineSelector(context),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.calendar_badge_plus,
            color: (deadlineTime == null) ? darkGrey : primaryColor,
            size: 40,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (deadlineDate != null && !timeOver)
                Text(
                  (deadlineDate!.day - DateTime.now().day == 0)
                      ? deadlineTime!.format(context)
                      : formatter1.format(deadlineDate!),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: primaryColor),
                ),
              if (deadlineDate != null && !timeOver)
                Text(
                  (deadlineDate!.day - DateTime.now().day == 0)
                      ? (deadlineTime!.hour - DateTime.now().hour == 0)
                          ? ("${deadlineTime!.minute - DateTime.now().minute} minutes left")
                          : "${deadlineTime!.hour - DateTime.now().hour} hours left"
                      : formatter2.format(deadlineDate!).toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: primaryColor),
                ),
              if (deadlineDate != null && timeOver)
                Text(
                  "Time Over!",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: alert),
                ),
              if (deadlineDate == null)
                Text("Select deadline",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: darkGrey))
            ],
          )
        ],
      ),
    );
  }
}
