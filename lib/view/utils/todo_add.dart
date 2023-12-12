import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/view/utils/snackbar.dart';
import '../../Constants/colors.dart';
import '../../controllers/bottom_sheet_text_fields.dart';
import 'buttons.dart';

void newToDo(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  String? selectedCategory;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future addTodo(Todo newTodo) async {
    debugPrint("Inside add todo");
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentReference newTodoRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('todo')
          .add(newTodo.toJson());
      Navigator.pop(context);
      debugPrint("todo added");
      String todoID = newTodoRef.id;
      await newTodoRef.update({'todoID': todoID});
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(e.message.toString(), context, isAlert: true);
    }
  }

  void saveTodo() {
    debugPrint("Inside save Todo");
    Todo newTodo = Todo(
        title: titleController.text.toString(),
        body: bodyController.text.toString(),
        category: selectedCategory.toString());
    if (formKey.currentState!.validate()) {
      debugPrint("validated");
      addTodo(newTodo);
    }
  }

  dynamic setCategory(String? newCategory) {
    selectedCategory = newCategory;
  }

  showModalBottomSheet(
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
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFieldBottomSheet(titleController, "Title"),
                                TextFieldBottomSheet(bodyController, "Body"),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: DropDownCategory(
                                            setCategory: setCategory),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: PrimaryButton(saveTodo,
                                            "Add"), // Call saveTodo function directly here
                                      ),
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
