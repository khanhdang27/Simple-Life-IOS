import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'guest_header_bar.dart';
import 'guest_navigation_bar.dart';

class GuestWithNavigation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const GuestWithNavigation({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)!.settings.name;
    return WillPopScope(
      onWillPop: () async {
        if (AppRoute.mainRoutes.contains(currentRoute)) {
          Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
        }
        return true;
      },
      child: Scaffold(
        appBar: GuestHeaderBar().apply(context),
        body: AnimatedBuilder(
          child: child,
          animation: animation,
          builder: (context, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1),
                end: Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  curve: Interval(
                    0.5,
                    1,
                    curve: Curves.easeOutCubic,
                  ),
                  parent: animation,
                ),
              ),
              child: SingleChildScrollView(
                child: child,
                scrollDirection: Axis.vertical,
              ),
            );
          },
        ),
        bottomNavigationBar: GuestNavigationBar(),
      ),
    );
  }
}
