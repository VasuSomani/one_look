import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/view/utils/snackbar.dart';
import '../../Constants/colors.dart';
import '../../controllers/bottom_sheet_text_fields.dart';
import 'buttons.dart';

void todoUpdate(BuildContext context, String todoID) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot todoSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('todo')
      .doc(todoID)
      .get();
  Map<String, dynamic> todoData = todoSnapshot.data() as Map<String, dynamic>;

  TextEditingController titleController =
      TextEditingController(text: todoData['title']);
  TextEditingController bodyController =
      TextEditingController(text: todoData['body']);
  String selectedCategory = todoData['category'];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> updateTodo(Todo updatedTodo) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('todo')
          .doc(todoID)
          .update(updatedTodo.toJson());
      Navigator.pop(context);
      showCustomSnackBar("Todo updated successfully", context);
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(e.message.toString(), context, isAlert: true);
    }
  }

  void saveTodo() {
    Todo updatedTodo = Todo(
      title: titleController.text.toString(),
      body: bodyController.text.toString(),
      category: selectedCategory.toString(),
    );

    if (formKey.currentState!.validate()) {
      updateTodo(updatedTodo);
    }
  }

  void setCategory(String? newCategory) {
    selectedCategory = newCategory!;
  }

  if (context.mounted) {
    showModalBottomSheet(
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.5 - 139,
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
                                          setCategory: setCategory,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: PrimaryButton(
                                          saveTodo,
                                          "Update",
                                        ),
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
            );
          },
        );
      },
    );
  }
}
