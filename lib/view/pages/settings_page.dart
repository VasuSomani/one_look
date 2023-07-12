import 'package:flutter/material.dart';
import 'package:todo/Constants/colors.dart';
import 'package:todo/view/utils/todo_tile.dart';
import '../utils/my_appbar.dart';
import '../utils/task_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor2,
        elevation: 0,
        centerTitle: false,
        titleTextStyle:
            Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 25),
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
            ],
          ),
        ),
      ),
    );
  }
}
