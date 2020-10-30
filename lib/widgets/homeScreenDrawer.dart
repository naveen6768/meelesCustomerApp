import 'package:flutter/material.dart';
import '../components/userProfileSectionDrawer.dart';
import '../components/drawerInkwellButtons.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class HomeScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            UserProfileSectionDrawer(),
            Center(
              child: DrawerButtons(
                buttonTitle: 'Home Page',
                buttonIcon: Icon(
                  Icons.home,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            DrawerButtons(
              buttonTitle: 'About us',
              buttonIcon: Icon(
                Icons.business_center,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Feedback',
              buttonIcon: Icon(
                Icons.feedback,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Contact us',
              buttonIcon: Icon(
                Icons.phone,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Logout',
              buttonIcon: Icon(
                Icons.backspace,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                await Provider.of<Auth>(context, listen: false).authlogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
