import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../Constants/colors.dart';
import '../pages/settings_page.dart';
import '../pages/tasks_page.dart';
import '../pages/todo_page.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({Key? key}) : super(key: key);

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingValue = screenWidth <= 360 ? 1.0 : 2.0;
    final iconScale = screenWidth <= 360 ? 1.2 : 1.5;
    final gNavHeight = screenWidth <= 360 ? 70.0 : 90.0;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [
            TodoPage(),
            TasksPage(),
            TasksPage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: Container(
          height: gNavHeight, // Set a fixed height for GNav
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              tabs: [
                GButton(
                  leading: Padding(
                    padding: EdgeInsets.only(right: paddingValue),
                    child: Image.asset(
                      'assets/icons/todo.png',
                      color: _selectedIndex == 0
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      scale: iconScale,
                    ),
                  ),
                  icon: const IconData(0),
                  text: "To-do",
                  textStyle: Theme.of(context).textTheme.caption?.copyWith(
                      color: _selectedIndex == 0
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      fontWeight: FontWeight.bold),
                ),
                GButton(
                  leading: Padding(
                    padding: EdgeInsets.only(right: paddingValue),
                    child: Image.asset(
                      'assets/icons/tasks.png',
                      color: _selectedIndex == 1
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      scale: iconScale,
                    ),
                  ),
                  textStyle: Theme.of(context).textTheme.caption?.copyWith(
                      color: _selectedIndex == 1
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      fontWeight: FontWeight.bold),
                  icon: const IconData(0),
                  text: "Tasks",
                ),
                GButton(
                  leading: Padding(
                    padding: EdgeInsets.only(right: paddingValue),
                    child: Image.asset(
                      'assets/icons/statistics.png',
                      color: _selectedIndex == 2
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      scale: iconScale,
                    ),
                  ),
                  icon: const IconData(0),
                  text: " Statistics",
                  textStyle: Theme.of(context).textTheme.caption?.copyWith(
                      color: _selectedIndex == 2
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      fontWeight: FontWeight.bold),
                ),
                GButton(
                  leading: Padding(
                    padding: EdgeInsets.only(right: paddingValue),
                    child: Image.asset(
                      'assets/icons/settings.png',
                      color: _selectedIndex == 3
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      scale: iconScale,
                    ),
                  ),
                  icon: const IconData(0),
                  text: " Settings",
                  textStyle: Theme.of(context).textTheme.caption?.copyWith(
                      color: _selectedIndex == 3
                          ? primaryColor
                          : const Color(0xFFB0B2C3),
                      fontWeight: FontWeight.bold),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
