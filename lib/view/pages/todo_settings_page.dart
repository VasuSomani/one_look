import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../models/todo.dart';
import '../utils/todo_tile.dart';

class TodoSettings extends StatelessWidget {
  const TodoSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<List<Todo>> fetchPendingTodos() {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('todo')
          .where('isCompleted', isEqualTo: false)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return Todo.fromJson(doc.data() as Map<String, dynamic>);
              }).toList());
    }

    Stream<List<Todo>> fetchCompletedTodos() {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('todo')
          .where('isCompleted', isEqualTo: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return Todo.fromJson(doc.data() as Map<String, dynamic>);
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
            child: Text("My Todo"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              StreamBuilder<List<Todo>>(
                stream: fetchPendingTodos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: primaryColor);
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
                                isCompleted: currTodo.isCompleted.toString(),
                                category: currTodo.category),
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
              ),
              StreamBuilder<List<Todo>>(
                stream: fetchCompletedTodos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: primaryColor);
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
                                isCompleted: currTodo.isCompleted.toString(),
                                body: currTodo.body,
                                category: currTodo.category),
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
                                "No Todo completed today \n Let's get back to work",
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
