import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/user.dart';
import 'package:todo/services/providers/user_provider.dart';
import 'package:todo/view/utils/task_delete.dart';
import 'package:todo/view/utils/task_update.dart';
import 'buttons.dart';
import 'task_chekbox.dart';

class TaskTile extends ConsumerStatefulWidget {
  TaskTile({
    Key? key,
    required this.title,
    required this.body,
    required this.deadlineDate,
    required this.deadlineTime,
    required this.taskID,
    required this.isCompleted,
  }) : super(key: key);
  final String taskID;
  final String title;
  final String body;
  final String deadlineDate;
  final String deadlineTime;
  String isCompleted;

  @override
  ConsumerState<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> {
  @override
  Widget build(BuildContext context) {
    UserModel? myUser = ref.watch(userProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        setState(() {
          (widget.isCompleted == 'false')
              ? (widget.isCompleted = 'true')
              : (widget.isCompleted = 'false');
        });
        debugPrint(widget.isCompleted);
        debugPrint(widget.taskID);
        debugPrint(myUser?.id);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(myUser?.id)
            .collection("task")
            .doc(widget.taskID)
            .update({"isCompleted": bool.parse(widget.isCompleted)});
        debugPrint(widget.isCompleted);
        debugPrint(widget.taskID);
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              TaskCheckBox(isCompleted: widget.isCompleted),
              SizedBox(width: width / 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 19)),
                    Text(widget.body, overflow: TextOverflow.ellipsis),
                    SizedBox(height: height / 85),
                    Text(
                      widget.deadlineTime,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      widget.deadlineDate,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              TileMenuButton(
                  updateFunction: () => taskUpdate(context, widget.taskID),
                  deleteFunction: () => taskDelete(context, widget.taskID))
            ],
          )),
    );
  }
}
