import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../services/providers/user_provider.dart';
import 'buttons.dart';
import 'todo_delete.dart';
import 'todo_update.dart';
import 'todo_checkbox.dart';

class TodoTile extends ConsumerStatefulWidget {
  TodoTile({
    Key? key,
    required this.todoID,
    required this.title,
    required this.body,
    required this.category,
    required this.isCompleted,
  }) : super(key: key);
  final String todoID;
  final String title;
  final String body;
  final String category;
  String isCompleted;

  @override
  ConsumerState<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends ConsumerState<TodoTile> {
  @override
  Widget build(BuildContext context) {
    UserModel? myUser = ref.watch(userProvider);
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        setState(() {
          (widget.isCompleted == 'false')
              ? (widget.isCompleted = 'true')
              : (widget.isCompleted = 'false');
        });
        await FirebaseFirestore.instance
            .collection("users")
            .doc(myUser?.id)
            .collection("todo")
            .doc(widget.todoID)
            .update({"isCompleted": bool.parse(widget.isCompleted)});
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CheckBox(isCompleted: widget.isCompleted),
            SizedBox(width: width / 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontSize: 19,
                              decoration: (widget.isCompleted == 'true')
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none)),
                  Text(widget.body, overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xFF58C6CD),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          widget.category,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            TileMenuButton(
                updateFunction: () => todoUpdate(context, widget.todoID),
                deleteFunction: () => todoDelete(context, widget.todoID))
          ],
        ),
      ),
    );
  }
}
