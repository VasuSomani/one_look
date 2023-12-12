import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../models/task.dart';
import '../utils/task_tile.dart';

class TasksSettings extends StatelessWidget {
  const TasksSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<List<Task>> fetchPendingTasks() {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('task')
          .where('isCompleted', isEqualTo: false)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return Task.fromJson(doc.data() as Map<String, dynamic>);
              }).toList());
    }

    Stream<List<Task>> fetchCompletedTasks() {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('task')
          .where('isCompleted', isEqualTo: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return Task.fromJson(doc.data() as Map<String, dynamic>);
              }).toList());
    }

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: bgColor2,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset('assets/icons/back.png'),
            ),
          ),
          backgroundColor: bgColor2,
          elevation: 0,
          centerTitle: false,
          bottom: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryColor,
            tabs: [
              Tab(
                  child: Text("Pending",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: primaryColor, fontWeight: FontWeight.bold))),
              Tab(
                  child: Text("Completed",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: primaryColor, fontWeight: FontWeight.bold))),
            ],
          ),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 25),
          title: const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text("My Tasks"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              StreamBuilder<List<Task>>(
                stream: fetchPendingTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: primaryColor);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Task> taskList = snapshot.data!;
                    List<Task> newList = taskList.reversed.toList();
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Task currTask = newList[index];
                          debugPrint(currTask.taskID);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TaskTile(
                              taskID: currTask.taskID ?? "",
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
                              const SizedBox(height: 15),
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
                      ),
                    );
                  }
                },
              ),
              StreamBuilder<List<Task>>(
                stream: fetchCompletedTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: primaryColor);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Task> taskList = snapshot.data!;
                    List<Task> newList = taskList.reversed.toList();
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Task currTask = newList[index];
                          debugPrint(currTask.taskID);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TaskTile(
                              taskID: currTask.taskID ?? "",
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
                                "No Task completed today \n Let's get back to work",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
