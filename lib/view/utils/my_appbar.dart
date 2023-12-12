import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

class MyAppBar extends SliverAppBar {
  final BuildContext context;
  final String name;
  MyAppBar(this.context, this.name)
      : super(
            backgroundColor: bgColor2,
            leadingWidth: 100,
            leading: Row(
              children: [
                SizedBox(width: 15),
                Image.asset('assets/images/logo.png'),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  'assets/icons/notification.png',
                  scale: 1.5,
                ),
              ),
            ],
            bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 15),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    name,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 40),
                  ),
                )),
            elevation: 0);
}
