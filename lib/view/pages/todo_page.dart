import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Constants/colors.dart';
import '../../models/todo.dart';
import '../../models/user.dart';
import '../../services/providers/user_provider.dart';
import '../utils/todo_add.dart';
import '../utils/todo_tile.dart';
import '../utils/my_appbar.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({Key? key}) : super(key: key);
  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  Stream<List<Todo>> fetchTodos() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todo')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Todo.fromJson(doc.data() as Map<String, dynamic>);
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    UserModel? myUser = ref.watch(userProvider);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor2,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            MyAppBar(
                context,
                (myUser != null)
                    ? ("Hi ${myUser.name.substring(0, myUser.name.indexOf(' '))} !")
                    : ("..."))
          ];
        },
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: height / 18,
                    bottom: height / 40,
                  ),
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
                        onPressed: () => newToDo(context),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<List<Todo>>(
                  stream: fetchTodos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                          color: primaryColor);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<Todo> todoList = snapshot.data!;
                      List<Todo> newList = todoList.reversed.toList();
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            Todo currTodo = newList[index];
                            debugPrint(currTodo.todoID);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TodoTile(
                                todoID: currTodo.todoID ?? "",
                                title: currTodo.title,
                                body: currTodo.body,
                                category: currTodo.category,
                                isCompleted: currTodo.isCompleted.toString(),
                              ),
                            );
                          },
                          itemCount: todoList.length,
                          padding: EdgeInsets.zero,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 40),
                                  child: Image.asset(
                                    'assets/images/completed_1.png',
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "No Todo left for the day",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: progress),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
