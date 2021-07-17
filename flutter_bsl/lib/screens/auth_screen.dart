import 'package:flutter/material.dart';
import 'package:flutter_bsl/widjets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bsl/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final authService = AuthService();

  void _submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await authService.submitAuthForm(email, password, username, isLogin);
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
