import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Constants/colors.dart';
import 'package:todo/view/utils/buttons.dart';

import '../utils/text_fields.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final name = TextEditingController();
    final emailID = TextEditingController();
    final password = TextEditingController();
    final confirmPassword = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void _authorize() {
      if (formKey.currentState!.validate()) {
        Navigator.pushNamed(context, '/pages');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height / 100),
                              child: TextFieldName(name),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height / 100),
                              child: TextFieldEmail(emailID),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height / 100),
                              child: TextFieldPass(password),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height / 100),
                              child: TextFieldConfirmPass(
                                  confirmPassword, password),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 30),
                          child: SizedBox(
                            width: width,
                            child: PrimaryButton(() => _authorize(), "Sign Up"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 100),
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
                                  style: Theme.of(context).textTheme.bodyLarge),
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
                              ElevatedButton(
                                  onPressed: null,
                                  style: ButtonStyle(
                                      side: const MaterialStatePropertyAll(
                                          BorderSide(
                                              width: 1,
                                              color:
                                                  CupertinoColors.systemGrey3)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Image.asset(
                                      'assets/icons/google.png',
                                      scale: 0.9,
                                    ),
                                  )),
                              ElevatedButton(
                                  onPressed: null,
                                  style: ButtonStyle(
                                      side: const MaterialStatePropertyAll(
                                          BorderSide(
                                              width: 1,
                                              color:
                                                  CupertinoColors.systemGrey3)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Image.asset(
                                      'assets/icons/fb.png',
                                      scale: 0.9,
                                    ),
                                  )),
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
    );
  }
}
