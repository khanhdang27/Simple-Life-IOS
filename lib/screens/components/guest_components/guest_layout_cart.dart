import 'package:baseproject/blocs/app_bloc.dart';
import 'package:baseproject/blocs/cart/cart_bloc.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestLayoutCart extends StatelessWidget {
  final Widget child;
  final bool? confirm;

  const GuestLayoutCart({
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
        appBar: GuestHeaderBar().apply(context),
        body: BlocBuilder(
          builder: (context, state) {
            return SingleChildScrollView(
              child: child,
              scrollDirection: Axis.vertical,
            );
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
                                      '貨品價格:',
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
                                      '運費:',
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
                                '訂單總價:',
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
                        '前往付款',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.monospace,
                          fontWeight: AppFont.wBold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.login);
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
                    route: AppRoute.guestHome,
                  ),
                  NavigationItem(
                    icon: AppIcon.heart,
                    title: AppLocalizations.t(context, 'myList'),
                    route: AppRoute.guestFavorite,
                  ),
                  NavigationItem(
                    icon: AppIcon.dollar,
                    title: AppLocalizations.t(context, 'purchaseHistory'),
                    route: AppRoute.guestOrder,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.login);
                    },
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(Icons.login, size: 25),
                        Text(
                          AppLocalizations.t(context, 'loginLabel'),
                          style: TextStyle(
                            fontWeight: AppFont.wRegular,
                            fontFamily: AppFont.madeTommySoft,
                          ),
                        ),
                        Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
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
