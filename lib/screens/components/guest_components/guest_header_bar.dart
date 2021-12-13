import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestHeaderBar {
  AppBar apply(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)!.settings.name;
    bool isHome = currentRoute == AppRoute.guestHome;
    return AppBar(
      toolbarHeight: 66,
      leading: IconButton(
        icon: !isHome ? Icon(Icons.arrow_back_ios) : Icon(Icons.notifications_none),
        color: AppColor.rBMain,
        onPressed: () {
          if (isHome) {
          } else {
            if (AppRoute.mainRoutes.contains(currentRoute)) {
              Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
            } else {
              Navigator.pop(context);
            }
          }
        },
      ),
      title: SizedBox(
        width: 195,
        child: Icon(
          AppIcon.logo,
          color: AppColor.rBMain,
          size: 40,
        ),
      ),
      centerTitle: true,
      actions: [
        SizedBox(
          width: 50,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(AppIcon.cart, color: AppColor.rBMain),
                BlocBuilder(
                  builder: (context, state) {
                    if (state is CartSuccess) {
                      return Positioned(
                        right: 5,
                        top: 10,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: state.quantity > 0 ? AppColor.rBMain : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: state.quantity > 0
                              ? Text(
                                  "${state.quantity}",
                                  style: TextStyle(
                                    color: AppColor.whiteMain,
                                    fontSize: 10,
                                    fontFamily: AppFont.madeTommySoft,
                                    fontWeight: AppFont.wRegular,
                                  ),
                                )
                              : null,
                        ),
                      );
                    }
                    return SizedBox();
                  },
                  bloc: AppBloc.cartBloc,
                ),
              ],
            ),
            onTap: () {
              if (AppRoute.guestCart != currentRoute) {
                Navigator.pushNamed(context, AppRoute.guestCart);
              }
            },
          ),
        ),
        IconButton(
            icon: Icon(
              AppIcon.search,
              color: AppColor.rBMain,
            ),
            onPressed: () {
              if (currentRoute != AppRoute.search) {
                Navigator.pushNamed(context, AppRoute.search);
              }
            }),
      ],
    );
  }
}
