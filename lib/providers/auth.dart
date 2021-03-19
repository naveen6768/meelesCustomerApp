import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  UserCredential authresult;
  Future<UserCredential> authlogin(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return authresult;
  }

  Future<UserCredential> authsignup(
      String email, String password, PhoneAuthCredential credential) async {
    authresult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseAuth.instance.currentUser.updatePhoneNumber(credential);

    notifyListeners();
    return authresult;
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

  Future<void> phonelogin(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    ///name = FirebaseAuth.instance.currentUser.displayName;
    notifyListeners();
    return null;
  }
  
}
