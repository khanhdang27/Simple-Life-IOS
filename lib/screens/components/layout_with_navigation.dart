import 'package:baseproject/blocs/app_bloc.dart';
import 'package:baseproject/blocs/auth/auth_bloc.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutWithNavigation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const LayoutWithNavigation({
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
        appBar: HeaderBar().apply(context),
        body: BlocBuilder(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return AnimatedBuilder(
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
              );
            }
            return Center(child: CircularProgressIndicator());
          },
          bloc: AppBloc.authBloc,
        ),
        bottomNavigationBar: NavigationBar(),
      ),
    );
  }
}
