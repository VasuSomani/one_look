import 'package:flutter/material.dart';
import 'package:todo/view/utils/animated_logo.dart';
import 'package:todo/view/utils/buttons.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedLogo(),
                    SizedBox(height: height / 20),
                    Text(
                      "Welcome to OneLook",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: height / 70),
                    Text(
                      "Just take a look and take action!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width / 15, right: width / 15, bottom: height / 50),
              child: SizedBox(
                width: width,
                child: PrimaryButton(
                    () => Navigator.pushNamed(context, '/onboard1'),
                    "Let's Start"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
