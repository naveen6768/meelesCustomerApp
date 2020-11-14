import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessDetailsData with ChangeNotifier {
  var currentuser = FirebaseAuth.instance.currentUser;
  var instant = FirebaseFirestore.instance.collection('Mess');
  Map<String, dynamic> mess_details;
  String show = 'Both';
  String landmark = 'KIET College';
  int bookings;

  void getmess(var doc) {
    mess_details = doc;
    notifyListeners();
  }

  Future<int> getbookings(type) async {
    await instant
        .doc(mess_details['Email'])
        .collection('Other Details')
        .doc('Booking')
        .collection(DateFormat.yMMMMEEEEd().format(DateTime.now()))
        .where('Type', isEqualTo: type)
        .get()
        .then((value) {
      bookings = value.size;
    }).whenComplete(() => null);
    return bookings;
  }

  get books {
    print(bookings);
    return bookings;
  }

  Future<Map<String, dynamic>> placedorder(data, cat) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Mess')
        .doc(mess_details['Email'])
        .collection('Booking')
        .doc(DateFormat.yMMMMEEEEd().format(DateTime.now()));

    var docref = await documentReference
        .collection(cat)
        .add({
          'Mess Name': mess_details['Shop Name'],
          'Name': currentuser.email,
          'Phone No': '1234567890',
          'Photo':
              'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
          'Type': cat,
          'Food Taken': false,
          'Payment Mode': 'Cash',
          'Price': data['Price'],
          'Item1': data['Item1'],
          'Item2': data['Item2'],
          'Item3': data['Item3'],
          'Item4': data['Item4'],
          'Booking Time': TimeOfDay.now().toString(),
          'Roti Quantity': data['Roti Quantity'],
          'Rice Type': data['Rice Type'],
          'Desert': data['Desert'],
        })
        .then((value) => value.id)
        .catchError((error) {
          if (error != null) return error;
        });

    FirebaseFirestore.instance.runTransaction((transaction) async {
      int updated;
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        await documentReference.set({
          'Lunch Instant': 0,
          'Lunch': 0,
          'Dinner': 0,
          'Dinner Instant': 0,
        });
      }
      if (cat[cat.length - 1] == 't') {
        if (snapshot.data()[cat] == 0)
          updated = int.parse(data['Instant']) - 1;
        else
          updated = snapshot.data()[cat] - 1;
      } else {
        if (snapshot.data()[cat] == 0)
          updated = int.parse(data['Seats']) - 1;
        else
          updated = snapshot.data()[cat] - 1;
      }
      transaction.update(documentReference, {'$cat': updated});
    });
    return {
      'docref': docref,
      'Name': currentuser.email,
      'Phone No': '1234567890',
      'Photo':
          'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
      'Type': data['type'],
      'Food Taken': false,
      'Payment Mode': 'Cash',
      'Price': data['Price'],
      'Item1': data['Item1'],
      'Item2': data['Item2'],
      'Item3': data['Item3'],
      'Item4': data['Item4'],
      'Roti Quantity': data['Roti Quantity'],
      'Rice Type': data['Rice Type'],
      'Desert': data['Desert'],
      'url': data['url'],
    };
  }

  void setshow(int index) {
    print('Got Index $index');
    if (index == 0)
      show = 'Both';
    else if (index == 1)
      show = 'Mess';
    else if (index == 2) show = 'Tifin';
    notifyListeners();
  }

  String get showshop {
    return show;
  }

  void setlandmark(String str) {
    landmark = str;
    notifyListeners();
  }

  String get landarea {
    return landmark;
  }
}
