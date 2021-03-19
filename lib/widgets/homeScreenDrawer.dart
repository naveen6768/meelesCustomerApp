import 'package:Meeles/screens/aboutus_screen.dart';
import 'package:Meeles/screens/contactus_screen.dart';
import 'package:Meeles/screens/feedback_screen.dart';
import 'package:Meeles/screens/viewbookings_screen.dart';
import 'package:Meeles/screens/wallet_screen.dart';
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
            // DrawerButtons(
            //   buttonTitle: 'Wallet',
            //   buttonIcon: Icon(
            //     Icons.business_center,
            //     color: Theme.of(context).accentColor,
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(Wallet.routeName);
            //   },
            // ),
            // DrawerButtons(
            //   buttonTitle: 'Bookings',
            //   buttonIcon: Icon(
            //     Icons.business_center,
            //     color: Theme.of(context).accentColor,
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(ViewBookings.routeName);
            //   },
            // ),
            DrawerButtons(
              buttonTitle: 'About us',
              buttonIcon: Icon(
                Icons.business_center,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AboutUs.routeName);
              },
            ),
            DrawerButtons(
              buttonTitle: 'Feedback',
              buttonIcon: Icon(
                Icons.feedback,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(FeedbackForm.routeName);
              },
            ),
            DrawerButtons(
              buttonTitle: 'Contact us',
              buttonIcon: Icon(
                Icons.phone,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(ContactUs.routeName);
              },
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
