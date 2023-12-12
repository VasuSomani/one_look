import 'package:flutter/material.dart';
import '../../Constants/colors.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _photoAnimation;
  late Animation<double> _line1Animation;
  late Animation<double> _line2Animation;
  late Animation<double> _line3Animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _photoAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    _line1Animation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeInOut),
      ),
    );

    _line2Animation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.9, curve: Curves.easeInOut),
      ),
    );

    _line3Animation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor2,
        elevation: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset('assets/icons/back.png'),
          ),
        ),
        titleTextStyle:
            Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 25),
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("About Us"),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: _photoAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(300 * _photoAnimation.value, 0),
                    child: child,
                  );
                },
                child: Container(
                  height: height / 3,
                  width: height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/me.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _line1Animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _line1Animation.value < 0 ? 0.0 : 1.0,
                    child: Transform.translate(
                      offset: Offset(300 * _line1Animation.value, 0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  "Hi, I'm Vasu Somani",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _line2Animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _line2Animation.value < 0 ? 0.0 : 1.0,
                    child: Transform.translate(
                      offset: Offset(300 * _line2Animation.value, 0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  "I made this app using Flutter and Firebase",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _line3Animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _line3Animation.value < 0 ? 0.0 : 1.0,
                    child: Transform.translate(
                      offset: Offset(300 * _line3Animation.value, 0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  "Here are some interesting facts:",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: _line3Animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _line3Animation.value < 0 ? 0.0 : 1.0,
                    child: Transform.translate(
                      offset: Offset(300 * _line3Animation.value, 0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  "- I love exploring new technologies",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: _line3Animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _line3Animation.value < 0 ? 0.0 : 1.0,
                    child: Transform.translate(
                      offset: Offset(300 * _line3Animation.value, 0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  "- I enjoy playing video games in my free time",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: _line3Animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _line3Animation.value < 0 ? 0.0 : 1.0,
                    child: Transform.translate(
                      offset: Offset(300 * _line3Animation.value, 0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  "- and I am SINGLE",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 50),
              AnimatedBuilder(
                animation: _line3Animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _line3Animation.value < 0 ? 0.0 : 1.0,
                    child: Transform.translate(
                      offset: Offset(300 * _line3Animation.value, 0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  "Feel free to reach out to me with any questions or feedback!",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
