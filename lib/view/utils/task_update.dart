import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/view/utils/snackbar.dart';
import '../../models/task.dart';
import 'task_deadline.dart';
import '../../Constants/colors.dart';
import '../../controllers/bottom_sheet_text_fields.dart';
import 'buttons.dart';

TimeOfDay unformatTime(String timeString) {
  List<String> timeParts = timeString.split(' ');
  List<String> timeDigits = timeParts[0].split(':');
  int hour = int.parse(timeDigits[0]);
  int minute = int.parse(timeDigits[1]);

  if (timeParts[1].toLowerCase() == 'pm' && hour < 12) {
    hour += 12;
  } else if (timeParts[1].toLowerCase() == 'am' && hour == 12) {
    hour = 0;
  }

  return TimeOfDay(hour: hour, minute: minute);
}

void taskUpdate(BuildContext context, String taskID) async {
  debugPrint("Entered taskUpdate");
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot taskRef = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('task')
      .doc(taskID)
      .get();
  Map<String, dynamic> taskData = taskRef.data() as Map<String, dynamic>;

  TextEditingController titleController =
      TextEditingController(text: taskData['title']);
  TextEditingController bodyController =
      TextEditingController(text: taskData['body']);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat formatter1 = DateFormat('dd/MM/yyyy');

  String deadlineDate = taskData['deadlineDate'];
  debugPrint(deadlineDate);
  String deadlineTime = taskData['deadlineTime'];
  debugPrint(deadlineTime);
  DateTime? selectedDate = formatter1.parse(deadlineDate);
  debugPrint(selectedDate.toString());
  TimeOfDay? selectedTime = unformatTime(deadlineTime);
  debugPrint(selectedTime.toString());

  Future updateTask(Task updatedTask) async {
    debugPrint("Inside update task");
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('task')
          .doc(taskID)
          .update(updatedTask.toJson());
      Navigator.pop(context);
      debugPrint("task updated");
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(e.message.toString(), context, isAlert: true);
    }
  }

  void saveTask() {
    debugPrint("Inside save Task");
    Task updatedTask = Task(
      title: titleController.text.toString(),
      body: bodyController.text.toString(),
      deadlineDate: (formatter1.format(selectedDate!)).toString(),
      deadlineTime: (selectedTime!.format(context)).toString(),
    );
    if (formKey.currentState!.validate()) {
      debugPrint("validated");
      updateTask(updatedTask);
    }
  }

  void setDateTime(DateTime? newDate, TimeOfDay? newTime) {
    selectedDate = newDate;
    selectedTime = newTime;
  }

  if (context.mounted) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: (MediaQuery.of(context).viewInsets.bottom == 0)
              ? 0.6
              : 1, // Set the initial height of the sheet
          minChildSize: (MediaQuery.of(context).viewInsets.bottom == 0)
              ? 0.6
              : 1, // Set the minimum height of the sheet
          maxChildSize: 1, // Set the maximum height of the sheet
          builder: (context, scrollController) {
            return ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.5 -
                                    139,
                              ),
                              Container(
                                height: 5,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: darkGrey,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Cancel",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: alert),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            controller: scrollController,
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: formKey,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFieldBottomSheet(
                                        titleController, "Title",
                                        isTask: true),
                                    TextFieldBottomSheet(bodyController, "Body",
                                        isTask: true),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TaskDeadline(
                                          setDateTime: setDateTime,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child:
                                              PrimaryButton(saveTask, "Update"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  } else {
    debugPrint("Not Mounted");
  }
}
