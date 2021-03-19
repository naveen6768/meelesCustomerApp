import 'package:Meeles/providers/messDetailsData.dart';
import 'package:Meeles/screens/aboutus_screen.dart';
import 'package:Meeles/screens/bookingdetails_screen.dart';
import 'package:Meeles/screens/contactus_screen.dart';
import 'package:Meeles/screens/feedback_screen.dart';
import 'package:Meeles/screens/mainScreen.dart';
import 'package:Meeles/screens/messListScreen.dart';
import 'package:Meeles/screens/messdetail.dart';
import 'package:Meeles/screens/phone.dart';
import 'package:Meeles/screens/searchScreen.dart';
import 'package:Meeles/screens/tabScreen.dart';
import 'package:Meeles/screens/viewbookings_screen.dart';
import 'package:flutter/material.dart';
import './screens/messOverviewScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './screens/feedback_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => MessDetailsData(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
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
          home: (auth.isAuth) ? TabScreen() : PhoneScreen() ,
          routes: {
            MessListScreen.routeName: (context) => MessListScreen(),
            SearchScreen.routeName: (context) => SearchScreen(),
            MainScreen.routeName: (context) => MainScreen(),
            MessDetail.routeName: (context) => MessDetail(),
            MessOverviewScreen.id: (context) => MessOverviewScreen(),
            BookRecipt.id: (context) => BookRecipt(),
            ContactUs.routeName: (context) => ContactUs(),
            AboutUs.routeName: (context) => AboutUs(),
            FeedbackForm.routeName: (context) => FeedbackForm(),
            ViewBookings.routeName: (context) => ViewBookings(),
          },
        ),
      ),
    );
  }
}
