import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    UserCredential authresult;

    try {
      if (isLogin) {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print('Authresult $authresult');
      } else {
        // password
        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print('Authresult $authresult');
        // Save Firestore collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authresult.user?.uid)
            .set({'username': username, 'email': email});
      }

      return authresult;
    } on PlatformException catch (err) {
      throw err;
    }
  }
}
