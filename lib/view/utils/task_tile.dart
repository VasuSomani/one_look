import 'package:flutter/material.dart';
import 'package:todo/view/utils/checkbox.dart';
import 'package:todo/view/utils/task_chekbox.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({Key? key}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: height / 7.5,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            TaskCheckBox(),
            SizedBox(width: width / 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Complete Project",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 19)),
                  const Text("Complete todo application in flutter by tonight",
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: height / 85),
                  Text(
                    "Task Deadline",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "11 July, 2023",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
