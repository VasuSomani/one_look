import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/services/providers/user_provider.dart';
import '../view/utils/snackbar.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //SignIn using email and password
  Future<UserModel?> signInEmail(
      {required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //Get user complete data from Firestore and give it to provider
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .get();
      UserModel myUser = UserModel(
          id: result.user!.uid, name: userData.data()!['name'], email: email);
      ref.read(userProvider.notifier).setUser(myUser);
      return myUser;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.message.toString(), context, isAlert: true);
      return null;
    }
  }

  //SignUp using data, email and password
  Future<UserModel?> signUpEmail(
      {required String name,
      required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = result.user.uid;
      UserModel myUser = UserModel(id: uid, name: name, email: email);
      await _db.collection('users').doc(uid).set(myUser.toJson()).then((value) {
        ref.read(userProvider.notifier).setUser(myUser);
      });
      return myUser;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.message.toString(), context, isAlert: true);
      return null;
    }
  }

  //Google SignIn
  Future<UserModel?> signInWithGoogle(
      {required BuildContext context, required WidgetRef ref}) async {
    final GoogleSignIn gSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? gUser = await gSignIn.signIn();
      if (gUser == null) return null;

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential gCredential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      final UserCredential userCredential =
          await _auth.signInWithCredential(gCredential);

      debugPrint(userCredential.user!.displayName);
      UserModel myUser = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName.toString(),
          email: userCredential.user!.email.toString());
      ref.read(userProvider.notifier).setUser(myUser);
      return myUser;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.message.toString(), context, isAlert: true);
      return null;
    }
  }

  //SignOut
  signOut(BuildContext context) async {
    try {
      GoogleSignIn().signOut();
      _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.message.toString(), context);
    }
  }

  //Forgot Password
  forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
