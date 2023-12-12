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

void newTask(BuildContext context) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat formatter1 = DateFormat('dd/MM/yyyy');
  DateTime? deadlineDate;
  TimeOfDay? deadlineTime;

  Future addTask(Task newTask) async {
    debugPrint("Inside add task");
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentReference newTaskRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('task')
          .add(newTask.toJson());
      Navigator.pop(context);
      debugPrint("task added");
      String taskID = newTaskRef.id;
      await newTaskRef.update({'taskID': taskID});
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(e.message.toString(), context, isAlert: true);
    }
  }

  void saveTask() async {
    debugPrint("Inside save Todo");
    if (formKey.currentState!.validate()) {
      Task newTask = Task(
        title: titleController.text.toString(),
        body: bodyController.text.toString(),
        deadlineDate: formatter1.format(deadlineDate!),
        deadlineTime: deadlineTime!.format(context),
      );
      debugPrint("validated");
      await addTask(newTask);
    }
  }

  dynamic setDateTime(DateTime? newDate, TimeOfDay? newTime) {
    deadlineTime = newTime;
    deadlineDate = newDate;
  }

  await showModalBottomSheet(
    useSafeArea: true,
    context: context,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Set the background to transparent
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  MediaQuery.sizeOf(context).width * 0.5 - 139),
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
                          autovalidateMode: AutovalidateMode.disabled,
                          key: formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFieldBottomSheet(titleController, "Title",
                                    isTask: true),
                                TextFieldBottomSheet(bodyController, "Body",
                                    isTask: true),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TaskDeadline(setDateTime: setDateTime),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: PrimaryButton(saveTask,
                                          "Add"), // Call saveTask function directly here
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
          );
        },
      );
    },
  );
}
