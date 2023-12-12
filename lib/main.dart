import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/view/pages/splash_screen.dart';
import 'package:todo/view/router/routes.dart';
import 'package:todo/view/utils/page_navigator.dart';
import 'Constants/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor1,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.notoSans(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
          headlineMedium: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          headlineSmall: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          ),
          bodyLarge: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
          bodyMedium: GoogleFonts.notoSans(
            color: const Color(0xFF898D9E),
            fontSize: 14,
            letterSpacing: 1.2,
          ),
          bodySmall: GoogleFonts.notoSans(
            color: const Color(0xFF898D9E),
            fontSize: 12,
            letterSpacing: 1.2,
          ),
          labelMedium: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
          labelSmall: GoogleFonts.notoSans(
            color: primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return const PageNavigator();
          }
          return const SplashScreen();
        },
      ),
    );
  }
}
