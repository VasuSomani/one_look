import 'package:flutter/material.dart';
import 'package:todo/Constants/colors.dart';
import 'package:todo/view/utils/todo_tile.dart';
import '../utils/my_appbar.dart';
import '../utils/task_tile.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor2,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: bgColor2,
              elevation: 0,
              pinned: true,
              bottom: PreferredSize(
                preferredSize: Size(width, 3.7),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, bottom: height / 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tasks List",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 25),
                      ),
                      TextButton(
                        onPressed: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              color: primaryColor,
                              size: 30,
                            ),
                            Text(
                              " Add Task",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Padding(
              padding: EdgeInsets.only(top: height / 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tasks Due",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TaskTile(),
                        );
                      },
                      itemCount: 12,
                      padding: EdgeInsets.zero,
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
