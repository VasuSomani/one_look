import 'package:flutter/material.dart';
import '../pages/about_us_page.dart';
import '../pages/my_account_page.dart';
import '../pages/todo_settings_page.dart';
import '../pages/on_boarding_page3.dart';
import '../pages/on_boarding_page2.dart';
import '../pages/on_boarding_page1.dart';
import '../pages/tasks_settings_page.dart';
import '../pages/welcome_page.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';
import '../utils/page_navigator.dart';

class Routes extends NavigatorObserver {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/onboard1':
        return MaterialPageRoute(builder: (_) => const OnBoardingPage1());
      case '/onboard2':
        return MaterialPageRoute(builder: (_) => const OnBoardingPage2());
      case '/onboard3':
        return MaterialPageRoute(builder: (_) => const OnBoardingPage3());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LogInPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/pages':
        return MaterialPageRoute(builder: (_) => const PageNavigator());
      case '/todo_settings':
        return MaterialPageRoute(builder: (_) => const TodoSettings());
      case '/tasks_settings':
        return MaterialPageRoute(builder: (_) => const TasksSettings());
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutUsPage());
      case '/account':
        return MaterialPageRoute(builder: (_) => MyAccountPage());

      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}
