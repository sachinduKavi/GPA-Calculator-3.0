import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'screens/About.dart';
import 'screens/CreateAccount.dart';
import 'screens/Degree02.dart';
import 'screens/LoginPage.dart';
import 'screens/UserProfile.dart';
import 'screens/courses.dart';
import 'screens/scale.dart';

void main() => runApp(const GpaCalculator());

class GpaCalculator extends StatelessWidget {
  const GpaCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: "GPA Calculator",
      routes: <String, WidgetBuilder>{
        'createAccount': (context) => const CreateAccount(),
        'loginPage': (context) => const LoginPage(),
        'courses': (context) => const Courses(),
        'degree': (context) => const Degree01(),
        // 'results': (context) => Results(2, 2, ""),
        'scale': (context) => const Scale(),
        'about': (context) => const About(),
        'user_profile': (context) => const UserProfile()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF6F61C0),
              foregroundColor: Colors.white),
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xFF6F61C0))),
      home: const LoginPage(),
    );
  }
}
