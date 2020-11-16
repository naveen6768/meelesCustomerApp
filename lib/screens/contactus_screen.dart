import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  static const routeName = '/contactus';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Company Name: Angrybaaz Service Private Limited',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Address: 45/7 Juhi Safed Colony, Kidwai Nagar Kanpur, 208014 ',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Contact No: 8171659272',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
