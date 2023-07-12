import 'package:flutter/material.dart';
import 'package:todo/view/utils/checkbox.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({Key? key}) : super(key: key);

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: height / 8,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CheckBox(),
            SizedBox(width: width / 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Complete Project",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 19)),
                  const Text("Complete todo application in flutter by tonight",
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFF58C6CD),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Work",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFF58C6CD),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Shopping",
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
            )
          ],
        ));
  }
}
