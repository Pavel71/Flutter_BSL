import 'package:flutter/material.dart';
import 'package:flutter_bsl/widjets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    UserCredential authresult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print('Authresult $authresult');
      } else {
        // password
        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print('Authresult $authresult');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authresult.user?.uid)
            .set({'username': username, 'email': email});
      }
    } on PlatformException catch (err) {
      final snackBar = SnackBar(
        content: Text('$err'),
        backgroundColor: Theme.of(context).errorColor,
      );
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}
