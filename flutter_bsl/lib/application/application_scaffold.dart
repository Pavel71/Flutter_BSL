import 'package:flutter/material.dart';
import 'package:flutter_bsl/application/tabbar.dart';
import 'package:flutter_bsl/application/adaptive_app_bar.dart';
import 'package:flutter_bsl/application/application_drawer.dart';

class ApplicationScaffold extends StatelessWidget {
  final Widget child;
  final int currentSelectedNavBarItem;
  final String title;

  ApplicationScaffold({
    required this.child,
    required this.currentSelectedNavBarItem,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AdaptiveAppBar(title: title),
        drawer: ApplicationDrawer(),
        body: child,
        bottomNavigationBar: ApplicationNavigationBar(
          currentSelectedItem: currentSelectedNavBarItem,
        ),
      ),
    );
  }
}
