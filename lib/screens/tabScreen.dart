import 'package:Meeles/screens/mainScreen.dart';
import 'package:Meeles/screens/profile.dart';
import 'package:Meeles/screens/searchScreen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    SearchScreen(),
    SearchScreen(),
    ProfileView(),
  ];

   _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: 40,
        elevation: 200,
        splashColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.black38,
        activeColor: Theme.of(context).primaryColor,
       // backgroundColor: Theme.of(context).primaryColor,
        leftCornerRadius: 20,
        rightCornerRadius:20,
      icons: const [Icons.home,Icons.search,Icons.food_bank, Icons.person,],
      activeIndex: _selectedIndex,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.defaultEdge,
      onTap: _onItemTapped,
      //other params
   ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedLabelStyle: TextStyle(fontFamily: 'Lato'),
      //   unselectedLabelStyle: TextStyle(fontFamily: 'Lato'),
        // items: const <BottomNavigationBarItem>[
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.home),
        //     label: 'Home',
        //     backgroundColor: Colors.white,
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.search),
        //     label: 'Search',
        //     backgroundColor: Colors.white,
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.person_outline_rounded),
        //     label: 'Profile',
        //     backgroundColor: Colors.white,
        //   ),
        // ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}