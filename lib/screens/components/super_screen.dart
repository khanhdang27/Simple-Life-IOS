import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuperScreen extends StatelessWidget {
  final Widget child;

  SuperScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          listener: (context, state) {
            if (state is AuthFailed) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.guestHome,
                (Route<dynamic> route) => false,
              );
            }
          },
          bloc: AppBloc.authBloc,
        ),
        BlocListener(
          listener: (context, state) {
            if (state is CartShowSuccess) {
              Fluttertoast.showToast(
                msg: 'Product added to cart successfully',
                backgroundColor: AppColor.rBMain,
                textColor: AppColor.whiteMain,
                timeInSecForIosWeb: 2,
                gravity: ToastGravity.CENTER,
              );
            }
          },
          bloc: AppBloc.cartBloc,
        )
      ],
      child: child,
    );
  }
}
