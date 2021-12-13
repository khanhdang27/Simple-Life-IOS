import 'package:baseproject/screens/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardLayout extends StatelessWidget {
  final Widget child;

  const CardLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: child,
        scrollDirection: Axis.vertical,
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }
}
