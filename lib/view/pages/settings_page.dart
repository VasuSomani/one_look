import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/utils/signout_dialog.dart';
import '../../Constants/colors.dart';
import '../../services/auth_service.dart';
import '../utils/snackbar.dart';
import '../utils/buttons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    AuthService authService = AuthService();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: bgColor2,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: bgColor2,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 25),
          title: const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text("Settings"),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ListView(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/account'),
                  child: ListTile(
                    title: Text(
                      "My Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    leading: Image.asset(
                      'assets/icons/user.png',
                    ),
                  ),
                ),
                Divider(color: Colors.grey, thickness: 0.7),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/todo_settings'),
                  child: ListTile(
                    title: Text(
                      "My To-do",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    leading: Image.asset(
                      'assets/icons/todo.png',
                      color: Colors.grey,
                      scale: 1.5,
                    ),
                  ),
                ),
                Divider(color: Colors.grey, thickness: 0.7),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/tasks_settings'),
                  child: ListTile(
                    title: Text(
                      "My Tasks",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    leading: Image.asset(
                      'assets/icons/tasks.png',
                      scale: 1.5,
                    ),
                  ),
                ),
                Divider(color: Colors.grey, thickness: 0.7),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/about'),
                  child: ListTile(
                      title: Text(
                        "About Us",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      leading: const Icon(Icons.phone_rounded)),
                ),
                Divider(color: Colors.grey, thickness: 0.7),
                InkWell(
                  onTap: () => signoutDialog(context),
                  child: ListTile(
                      title: Text(
                        "Log Out",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 18, color: alert),
                      ),
                      leading: const Icon(
                        Icons.logout,
                        color: alert,
                      )),
                ),
                Divider(color: Colors.grey, thickness: 0.7),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
