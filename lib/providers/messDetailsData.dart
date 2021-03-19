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
  var phoneNo;
  int bookings;
  Map<String, dynamic> seatsleft;
  var messemail,day,lunchtime,dinnertime,isopen;
  void getmess(var doc) async {
    mess_details = doc;
    notifyListeners();
  }

  Future<Map<String, dynamic>> placedorder(data, cat, mode) async {
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
          'Payment Mode': mode,
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
          'Lunch Instant': 999,
          'Lunch': 999,
          'Dinner': 999,
          'Dinner Instant': 999,
        });
      }
      if (cat[cat.length - 1] == 't') {
        if (snapshot.data()[cat] == 999)
          updated = int.parse(data['Instant']) - 1;
        else
          updated = snapshot.data()[cat] - 1;
      } else {
        if (snapshot.data()[cat] == 999)
          updated = int.parse(data['Seats']) - 1;
        else
          updated = snapshot.data()[cat] - 1;
      }
      transaction.update(documentReference, {'$cat': updated});
    });
    var bookingdetails;
    bookingdetails = await FirebaseFirestore.instance
        .collection('Customer')
        .doc(currentuser.email)
        .collection('Bookings')
        .add({
      'Order Id': docref,
      'Name': currentuser.email,
      'Phone No': '1234567890',
      'Type': data['type'],
      'Food Taken': false,
      'Payment Mode': mode,
      'Price': data['Price'],
      'Item1': data['Item1'],
      'Item2': data['Item2'],
      'Item3': data['Item3'],
      'Item4': data['Item4'],
      'Mess Name': mess_details['Shop Name'],
      'Date': DateFormat.yMd().add_jm().format(new DateTime.now()),
      'Roti Quantity': data['Roti Quantity'],
      'Rice Type': data['Rice Type'],
      'Desert': data['Desert'],
      'url': data['url'],
    }).then((value) => value.get());
    print('Bookig Details are $bookingdetails');
    return bookingdetails.data();
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

  void setmessvalue(me,lt,dt,io,ph){
    messemail = me;
    phoneNo = ph;
    lunchtime = lt;
    dinnertime = dt;
    isopen = io;
    notifyListeners();
  }
  set daydata(dy){
    day = dy;
    notifyListeners();
  }

  String get messphone{
    return phoneNo;
  }
}