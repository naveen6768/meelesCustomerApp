import 'package:flutter/material.dart';
import '../widgets/homeScreenDrawer.dart';
import 'package:provider/provider.dart';
import '../widgets/switcherButton.dart';
import '../widgets/textFieldAppBar.dart';
import '../widgets/textAppBar.dart';
import '../widgets/menuIconBotton.dart';
import '../widgets/menuUserIconButton.dart';
import '../widgets/filterButton.dart';
import '../components/containerClipper.dart';
// import '../models/messDetails.dart';
import '../widgets/messTile.dart';
import '../providers/messDetailsData.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'HomeScreen';
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _drawerKey,
      drawer: HomeScreenDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: ContainerClipper(),
              child: Container(
                height: screenSize.height * 0.20,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MenuIconButton(
                      onPressed: () {
                        _drawerKey.currentState.openDrawer();
                      },
                    ),
                    Container(
                      height: 68.0,
                      width: 180.0,
                      child: Column(
                        children: [
                          TextAppBar(),
                          SizedBox(height: 7.0),
                          TextFieldAppBar(),
                        ],
                      ),
                    ),
                    UserIconButton(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SwitcherButton(),
            Expanded(
              child: MessTile(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterButton(
                    buttonIcon: Icon(Icons.filter),
                    buttonTitle: 'Filter',
                    buttonOnPressed: () {},
                  ),
                  FilterButton(
                    buttonIcon: Icon(Icons.sort),
                    buttonTitle: 'Sort',
                    buttonOnPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
