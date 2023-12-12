import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'snackbar.dart';

Future taskDelete(BuildContext context, String taskID) async {
  debugPrint("Entered taskDelete");
  String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('task');
  DocumentSnapshot snapshot = await ref.doc(taskID).get();
  Object? deletedtask = snapshot.data();
  debugPrint(taskID);
  await ref.doc(taskID).delete();
  // if (context.mounted) {
  //   showConfirmationSnackBar(
  //     "task deleted successfully",
  //     context,
  //     () {
  //       ref.doc(taskID).set(deletedtask);
  //     },
  //   );
  // } else {
  //   debugPrint("false");
  // }
}
