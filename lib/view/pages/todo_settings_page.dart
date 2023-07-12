import 'package:flutter/material.dart';
import 'package:todo/Constants/colors.dart';
import 'package:todo/view/utils/todo_tile.dart';

class TodoSettings extends StatelessWidget {
  const TodoSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              // Completed Tasks Section
              ListView.builder(
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TodoTile(),
                  );
                },
                itemCount:
                    5, // Replace with the actual number of completed tasks
              ),
              // Pending Tasks Section
              ListView.builder(
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TodoTile(),
                  );
                },
                itemCount:
                    10, // Replace with the actual number of pending tasks
              ),
            ],
          ),
        ),
      ),
    );
  }
}
