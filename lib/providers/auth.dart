import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  UserCredential authresult;
  Future<void> authlogin(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(authresult);
    notifyListeners();
    return null;
  }

  Future<void> authsignup(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return null;
  }

  Future<void> authlogout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  bool get isAuth {
    if (FirebaseAuth.instance.currentUser == null)
      return false;
    else
      return true;
  }
}
