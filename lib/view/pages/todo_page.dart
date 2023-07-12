import 'package:flutter/material.dart';
import 'package:todo/Constants/colors.dart';
import 'package:todo/view/utils/todo_tile.dart';
import '../utils/my_appbar.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: bgColor2,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [MyAppBar(context)];
          },
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 20, bottom: height / 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "To-do List",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 25),
                        ),
                        TextButton(
                            onPressed: null,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: primaryColor,
                                  size: 30,
                                ),
                                Text(
                                  " Add To-do",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TodoTile(),
                        );
                      },
                      padding: EdgeInsets.zero,
                      itemCount: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
