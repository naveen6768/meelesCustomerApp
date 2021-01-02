import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewBookings extends StatelessWidget {
  static const routeName = '/viewbookings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Bookings',
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Customer')
              .doc(FirebaseAuth.instance.currentUser.email)
              .collection('Bookings')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.data.docs.isEmpty)
              return Center(
                child: Text(
                  'No Bookings Let',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              );

            return ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children:
                  snapshot.data.docs.map((QueryDocumentSnapshot document) {
                return ListTile(
                  title: Text(
                    document.data()['Mess Name'],
                    style: TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  subtitle: Text(
                    document.data()['Date'],
                    style: TextStyle(fontFamily: 'Lato'),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
