import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      String email, String password, String userName, bool isLogin) submitFn;

  var isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();

    FocusScope.of(context).unfocus();

    if (isValid ?? false) {
      _formKey.currentState?.save();
      // Use value to set our auth
      widget.submitFn(
          _userEmail.trim(), _userPassword.trim(), _userName.trim(), _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('Email'),
                    validator: (value) {
                      String val = value ?? "";
                      if (val.isEmpty || val.contains('@') == false) {
                        return 'Please enter correct email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email adress'),
                    onSaved: (value) {
                      _userEmail = value ?? "";
                    },
                  ),
                  if (_isLogin == false)
                    TextFormField(
                      key: ValueKey('User Name'),
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (vale) {
                        _userName = vale ?? "";
                      },
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    validator: (value) {
                      String val = value ?? "";

                      if (val.isEmpty || val.length < 7) {
                        return 'Password Showld be longer ail';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text(_isLogin ? 'Login' : 'Sing Up'),
                          onPressed: _trySubmit),
                  TextButton(
                      child: Text(_isLogin
                          ? 'Create account'
                          : 'I have alreadyy an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
