import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/user.dart';
import 'package:todo/view/pages/forgot_password_page.dart';
import '../../Constants/colors.dart';
import '../../controllers/auth_text_fields.dart';
import '../../services/auth_service.dart';
import '../utils/buttons.dart';
import '../utils/snackbar.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final emailID = TextEditingController();
    final password = TextEditingController();
    final authService = AuthService();

    void authorize() async {
      setState(() {
        _isLoading = true;
      });
      UserModel? myUser = await authService.signInEmail(
          email: emailID.text.toString(),
          password: password.text.toString(),
          ref: ref,
          context: context);
      setState(() {
        _isLoading = false;
      });
      if (myUser != null) {
        Navigator.pushNamed(context, '/pages');
        showCustomSnackBar("Logged In successfully", context);
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
        showCustomSnackBar("Logged In successfully", context);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 15),
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height / 40),
                    child: Text(
                      "Welcome back",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, "/forgot_password"),
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height / 30),
                                  child: SizedBox(
                                    width: width,
                                    child: PrimaryButton(
                                        () => authorize(), "Log In",
                                        isLoading: _isLoading),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height / 100),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
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
                                      vertical: height / 50,
                                      horizontal: width / 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SocialButton(
                                        onPressed: googleAuthorize,
                                        isLogin: true,
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
                                        "Don't have an account?  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.pushNamed(
                                            context, '/signup'),
                                        child: Text(
                                          "Sign Up",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
