import 'package:baseproject/screens/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutWithoutNavigation extends StatelessWidget {
  final Widget? child;

  const LayoutWithoutNavigation({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar().apply(context),
      body: SingleChildScrollView(
        child: child,
        scrollDirection: Axis.vertical,
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }
}
