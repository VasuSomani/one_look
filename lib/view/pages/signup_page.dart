import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Constants/colors.dart';
import '../../models/user.dart';
import '../utils/buttons.dart';
import '../utils/snackbar.dart';
import '../../controllers/auth_text_fields.dart';
import '../../services/auth_service.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final name = TextEditingController();
    final emailID = TextEditingController();
    final password = TextEditingController();
    final confirmPassword = TextEditingController();
    final AuthService authService = AuthService();

    void _authorize() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        UserModel? myUser = await authService.signUpEmail(
            name: name.text.toString(),
            email: emailID.text.toString(),
            password: password.text.toString(),
            context: context,
            ref: ref);
        setState(() {
          _isLoading = false;
        });
        if (myUser != null) {
          Navigator.pushNamed(context, '/pages');
          showCustomSnackBar("Account created successfully", context);
        }
      }
    }

    void googleAuthorize() async {
      setState(() {
        _isLoading = true;
      });
      UserModel? myUser =
          await authService.signInWithGoogle(ref: ref, context: context);
      setState(() {
        _isLoading = false;
      });
      if (myUser != null) {
        Navigator.pushNamed(context, '/pages');
        showCustomSnackBar("Account created successfully", context);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 15),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height / 40),
                      child: Text(
                        "Create an Account",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child: TextFieldName(name, validationOn: true),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child: TextFieldEmail(emailID, validationOn: true),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child: TextFieldPass(password, validationOn: true),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child:
                                TextFieldConfirmPass(confirmPassword, password),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 30),
                            child: SizedBox(
                              width: width,
                              child: PrimaryButton(
                                  () => _authorize(), "Sign Up",
                                  isLoading: _isLoading),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: CupertinoColors.systemGrey3,
                                  ),
                                ),
                                Text("  Or  ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                const Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: CupertinoColors.systemGrey3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height / 50, horizontal: width / 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SocialButton(
                                  onPressed: googleAuthorize,
                                  isLogin: false,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: height / 75, bottom: height / 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/login'),
                                  child: Text(
                                    "Log In",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
