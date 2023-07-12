import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

class MyAppBar extends SliverAppBar {
  final BuildContext context;
  MyAppBar(this.context)
      : super(
            backgroundColor: bgColor2,
            actions: [
              Image.asset('assets/images/logo_small.png'),
              SizedBox(width: MediaQuery.of(context).size.width * 0.62),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                    height: 56,
                    width: 56,
                    color: Colors.white,
                    margin: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/icons/notification.png',
                      scale: 1.5,
                    )),
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
                    "Hi Vasu!",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 40),
                  ),
                )),
            elevation: 0);
}
