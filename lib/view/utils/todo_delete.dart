import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/utils/snackbar.dart';

Future todoDelete(BuildContext context, String todoID) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('todo');
  DocumentSnapshot snapshot = await ref.doc(todoID).get();
  Object? deletedTodo = snapshot.data();
  debugPrint(todoID);
  await ref.doc(todoID).delete();
  if (context.mounted) {
    showConfirmationSnackBar(
      "Todo deleted successfully",
      context,
      () {
        ref.doc(todoID).set(deletedTodo);
      },
    );
  } else {
    debugPrint("false");
  }
}
