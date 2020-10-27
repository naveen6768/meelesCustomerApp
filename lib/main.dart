import 'package:flutter/material.dart';
import './screens/messOverviewScreen.dart';
import './screens/welcomeScreen.dart';
import './screens/loginScreen.dart';
import './screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Color(0xffB4344D),
        ),
        accentColor: Color(0xffF1F1F1),
        primaryColor: Color(0xffB4344D),
        cursorColor: Color(0xffB4344D),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        MessOverviewScreen.id: (context) => MessOverviewScreen(),
      },
    );
  }
}
