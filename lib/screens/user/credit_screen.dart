import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditScreen extends StatefulWidget {
  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  @override
  void initState() {
    AppBloc.creditCardBloc.add(CreditCardOne());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.pinkLight,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: AppColor.rBMain,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    AppAsset.creditCard,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: BlocBuilder(
                    builder: (context, state) {
                      if (state is CreditCardLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      String begin = '****';
                      if (state is CreditCardOneSuccess) {
                        begin = state.card.number.toString();
                      }
                      return Text(
                        '**** **** **** ' + begin,
                        style: TextStyle(fontSize: 20),
                      );
                    },
                    bloc: AppBloc.creditCardBloc,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder(
            builder: (context, state) {
              if (state is CreditCardLoading) {
                return SizedBox();
              }
              return Wrap(
                direction: Axis.vertical,
                children: [
                  BlocBuilder(
                    builder: (context, state) {
                      String begin = AppLocalizations.t(context, 'add');
                      if (state is CreditCardOneSuccess) {
                        begin = AppLocalizations.t(context, 'edit');
                      }
                      return GestureDetector(
                        onTap: () {
                          if (state is CreditCardOneSuccess) {
                            Navigator.pushNamed(context, AppRoute.creditEdit,
                                arguments: {'creditCard': state.card});
                          }
                          if (state is CreditCardFail || state is CreditCardRemoveSuccess) {
                            Navigator.pushNamed(context, AppRoute.creditAdd);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 200,
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            color: AppColor.pinkLight,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Text(
                            begin,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFont.madeTommySoft,
                              fontWeight: AppFont.wMedium,
                            ),
                          ),
                        ),
                      );
                    },
                    bloc: AppBloc.creditCardBloc,
                  ),
                  Builder(
                    builder: (context) {
                      if (state is CreditCardOneSuccess) {
                        return GestureDetector(
                          onTap: () {
                            AppBloc.creditCardBloc.add(CreditCardRemove());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 200,
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              color: AppColor.pinkLight,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: AppFont.madeTommySoft,
                                fontWeight: AppFont.wMedium,
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  Builder(
                    builder: (context) {
                      if (state is CreditCardOneSuccess) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.popUntil(context, (route) {
                              return route.settings.name == AppRoute.user;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 200,
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              color: AppColor.pinkLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: AppFont.madeTommySoft,
                                fontWeight: AppFont.wMedium,
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              );
            },
            bloc: AppBloc.creditCardBloc,
          ),
        ],
      ),
    );
  }
}
