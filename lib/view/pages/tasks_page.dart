import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../models/task.dart';
import '../utils/task_add.dart';
import '../utils/task_tile.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Stream<List<Task>> fetchTasks() {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Task.fromJson(doc.data());
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor2,
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      onPressed: () => newTask(context),
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
          ],
        ),
        backgroundColor: bgColor2,
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Padding(
              padding: EdgeInsets.only(
                top: height / 40,
                bottom: height / 40,
              ),
              child: StreamBuilder<List<Task>>(
                stream: fetchTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: primaryColor);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Task> taskList = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Task currTask = taskList[taskList.length - index - 1];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TaskTile(
                              taskID: currTask.taskID!,
                              title: currTask.title,
                              body: currTask.body,
                              deadlineDate: currTask.deadlineDate,
                              deadlineTime: currTask.deadlineTime,
                              isCompleted: currTask.isCompleted.toString(),
                            ),
                          );
                        },
                        itemCount: taskList.length,
                        padding: EdgeInsets.zero,
                      ),
                    );
                  } else {
                    return Center(
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/completed_2.png'),
                            Text(
                              "No Task left for the day",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: progress),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
