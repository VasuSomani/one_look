import 'package:flutter/material.dart';
import 'package:todo/view/utils/buttons.dart';

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFD0D1FF),
      body: SafeArea(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: width / 20, top: height / 50),
                  child: SecondaryButton(
                      () => Navigator.pushNamed(context, '/login'), "Skip"),
                )),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/yoga.png'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      child: Text(
                        "Exercise more & breathe better",
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Learn, measure, set daily goals.",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width / 15, right: width / 15, bottom: height / 50),
              child: PrimaryButton(
                  () => Navigator.pushNamed(context, '/login'), "Finish"),
            )
          ],
        ),
      ),
    );
  }
}
