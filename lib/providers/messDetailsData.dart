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
  void getmess(var doc) {
    mess_details = doc;
    print(mess_details);
  }

  Future<Map<String, dynamic>> placedorder(data) async {
    var docref = await instant
        .doc(mess_details['Email'])
        .collection('Other Details')
        .doc('Booking')
        .collection(DateFormat.yMMMMEEEEd().format(DateTime.now()))
        .add({
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
        })
        .then((value) => value.id)
        .catchError((error) {
          var message = "An Error occured, Please Check your Credentials";
          if (error.message != null) message = error.message;
          return message;
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
