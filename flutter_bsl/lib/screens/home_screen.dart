import 'package:flutter/material.dart';
import 'package:flutter_bsl/application/application_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationScaffold(
        child: Container(
          color: Colors.green,
        ),
        currentSelectedNavBarItem: 0,
        title: "Home");
  }
}
