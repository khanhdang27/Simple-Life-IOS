import 'package:baseproject/blocs/app_bloc.dart';
import 'package:baseproject/blocs/auth/auth_bloc.dart';
import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/blocs/cart/cart_bloc.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LayoutCart extends StatelessWidget {
  final Widget child;
  final bool? confirm;

  const LayoutCart({
    Key? key,
    required this.child,
    this.confirm = false,
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
              return SingleChildScrollView(
                child: child,
                scrollDirection: Axis.vertical,
              );
            }
            return Center(child: CircularProgressIndicator());
          },
          bloc: AppBloc.authBloc,
        ),
        bottomNavigationBar: BlocBuilder(
          builder: (context, state) {
            if (state is CartSuccess && state.amount > 0) {
              return _CartBottom();
            }
            return SizedBox();
          },
          bloc: AppBloc.cartBloc,
        ),
      ),
    );
  }
}

class _CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 3,
      ),
      decoration: BoxDecoration(
        color: AppColor.pinkLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Text(
                                      '????????????:',
                                      style: TextStyle(
                                          fontWeight: AppFont.wMedium,
                                          fontFamily: AppFont.monospace,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    child: SingleChildScrollView(
                                      child: BlocBuilder(
                                        builder: (context, state) {
                                          if (state is CartSuccess) {
                                            return Text(
                                              "\$${state.cost}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontFamily: AppFont.madeTommySoft,
                                                fontWeight: AppFont.wMedium,
                                              ),
                                            );
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        bloc: AppBloc.cartBloc,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Text(
                                      '??????:',
                                      style: TextStyle(
                                          fontWeight: AppFont.wMedium,
                                          fontFamily: AppFont.monospace,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    child: SingleChildScrollView(
                                      child: BlocBuilder(
                                        builder: (context, state) {
                                          if (state is CartSuccess) {
                                            return Text(
                                              "\$${state.discount}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontFamily: AppFont.madeTommySoft,
                                                fontWeight: AppFont.wMedium,
                                              ),
                                            );
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        bloc: AppBloc.cartBloc,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColor.whiteMain),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(
                                '????????????:',
                                style: TextStyle(
                                    fontWeight: AppFont.wMedium,
                                    fontFamily: AppFont.monospace,
                                    fontSize: 18),
                              ),
                            ),
                            Container(
                              width: 130,
                              alignment: Alignment.centerRight,
                              child: SingleChildScrollView(
                                child: BlocBuilder(
                                  builder: (context, state) {
                                    if (state is CartSuccess) {
                                      return Text(
                                        "\$${state.amount}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: AppFont.madeTommySoft,
                                          fontWeight: AppFont.wMedium,
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  bloc: AppBloc.cartBloc,
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 15),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColor.whiteMain,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        '????????????',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.monospace,
                          fontWeight: AppFont.wBold,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (ModalRoute.of(context)!.settings.name == AppRoute.cartConfirm) {
                        AppBloc.shippingBloc.add(ShippingGet());
                        if (AppSharedPrefs.getLoginType() == AppSharedPrefs.loginExternal) {
                          if (AppSharedPrefs.getPhone() != '') {
                            Navigator.pushNamed(context, AppRoute.checkout);
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(AppLocalizations.t(context, 'needPhone')),
                                  content: Text(AppLocalizations.t(context, 'redirectAccount')),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(AppLocalizations.t(context, 'ok')),
                                      onPressed: () {
                                        Navigator.pushNamed(context, AppRoute.user);
                                      },
                                    ),
                                    TextButton(
                                      child: Text(AppLocalizations.t(context, 'later')),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          Navigator.pushNamed(context, AppRoute.checkout);
                        }
                      } else {
                        Navigator.pushNamed(context, AppRoute.cartConfirm);
                      }
                    },
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.brownPink),
                color: AppColor.pinkLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavigationItem(
                    icon: AppIcon.home,
                    title: AppLocalizations.t(context, 'home'),
                    route: AppRoute.home,
                  ),
                  NavigationItem(
                    icon: AppIcon.heart,
                    title: AppLocalizations.t(context, 'myList'),
                    route: AppRoute.favorite,
                  ),
                  NavigationItem(
                    icon: AppIcon.dollar,
                    title: AppLocalizations.t(context, 'purchaseHistory'),
                    route: AppRoute.order,
                  ),
                  NavigationItem(
                    icon: AppIcon.user,
                    title: AppLocalizations.t(context, 'accountSettings'),
                    route: AppRoute.user,
                  ),
                ],
              ),
            ),
          ],
        ),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
