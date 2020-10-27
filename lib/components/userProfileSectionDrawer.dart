import 'package:flutter/material.dart';

class UserProfileSectionDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        'Praveen Kumar',
        style: const TextStyle(
            color: Color(0xff213e3b),
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500),
      ),
      accountEmail: Text(
        'kpravin627@gmail.com',
        style: const TextStyle(
            color: Color(0xff213e3b),
            fontSize: 14.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w300),
      ),
      currentAccountPicture: GestureDetector(
        onTap: () {
          print('pressed');
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
