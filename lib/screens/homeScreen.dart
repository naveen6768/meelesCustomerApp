import 'package:Meeles/providers/messDetailsData.dart';
import 'package:flutter/material.dart';
import '../widgets/homeScreenDrawer.dart';
import '../widgets/textFieldAppBar.dart';
import '../widgets/textAppBar.dart';
import '../widgets/menuIconBotton.dart';
import '../widgets/menuUserIconButton.dart';
import 'package:provider/provider.dart';
import '../components/containerClipper.dart';
import '../widgets/messTile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    String show = 'Both';

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
                      width: 250.0,
                      child: TextAppBar(),
                    ),
                    UserIconButton(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ToggleSwitch(
              initialLabelIndex: 0,
              inactiveFgColor: Colors.white,
              labels: ['All', 'Mess', 'Tifin'],
              onToggle: (index) {
                print('switched to: $index');
                Provider.of<MessDetailsData>(context, listen: false)
                    .setshow(index);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: MessTile(),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       FilterButton(
            //         buttonIcon: Icon(Icons.filter),
            //         buttonTitle: 'Filter',
            //         buttonOnPressed: () {},
            //       ),
            //       FilterButton(
            //         buttonIcon: Icon(Icons.sort),
            //         buttonTitle: 'Sort',
            //         buttonOnPressed: () {},
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
