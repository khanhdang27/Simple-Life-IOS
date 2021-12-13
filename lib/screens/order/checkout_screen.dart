import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/app_localizations.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const DELIVERY_PICK_FROM_STORE = "PICK_UP";
  static const DELIVERY_YOUR_DOOR = "YOUR_DOOR";
  static const METHOD_PAY_PAL = "PAYPAL";
  static const METHOD_CREDIT_CARD = "CREDIT_CARD";
  static const METHOD_STORE_PAYMENT = "CASH";

  String _delivery = DELIVERY_PICK_FROM_STORE;
  String _method = METHOD_PAY_PAL;
  bool _editAddress = false;
  TextEditingController _addressCtrl = TextEditingController();
  int? couponId;
  int? fee;
  String? couponName = '-';
  String? couponValue = '0';
  String? shippingFee = '0';

  @override
  void initState() {
    AppBloc.cartBloc.add(CartGet());
    AppBloc.profileBloc.add(ProfileGet());
    AppBloc.creditCardBloc.add(CreditCardOne());
    super.initState();
  }

  @override
  void dispose() {
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: BlocBuilder(
        builder: (context, state) {
          if (state is CartSuccess) {
            return BlocBuilder(
              builder: (context, creditState) {
                if (creditState is CreditCardLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.t(context, 'goods'),
                            style: TextStyle(
                              fontFamily: AppFont.monospace,
                              fontWeight: AppFont.wBold,
                              fontSize: 15,
                              color: AppColor.rBMain,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppColor.rBMain)),
                      ),
                    ),
                    _Item(products: state.products),
                    discount(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.t(context, 'total'),
                              style: _TextStyleMono(),
                            ),
                          ),
                          Text(
                            '\$${state.amount+double.parse(shippingFee!)-double.parse(couponValue!)}',
                            style: _TextStyleMadeByTommy(),
                          )
                        ],
                      ),
                    ),
                    coupon(),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      value: DELIVERY_PICK_FROM_STORE,
                                      groupValue: _delivery,
                                      onChanged: (T) {
                                        setState(() {
                                          _delivery = DELIVERY_PICK_FROM_STORE;
                                          fee = null;
                                          shippingFee = '0';
                                        });
                                      },
                                    ),
                                    Text(
                                      AppLocalizations.t(context, 'pickUpFromStore'),
                                      style: _TextStyleMono(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder(
                            builder: (context, state) {
                              if (state is ShippingGetSuccess) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Radio(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            value: DELIVERY_YOUR_DOOR,
                                            groupValue: _delivery,
                                            onChanged: (T) {
                                              setState(() {
                                                _delivery = DELIVERY_YOUR_DOOR;
                                                fee = state.shipping.id;
                                                shippingFee = state.shipping.value.toString();
                                              });
                                            },
                                          ),
                                          Text(
                                            state.shipping.name!,
                                            style: _TextStyleMono(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '\$' + state.shipping.value.toString(),
                                      style: _TextStyleMadeByTommy(),
                                    ),
                                  ],
                                );
                              }
                              return SizedBox();
                            },
                            bloc: AppBloc.shippingBloc,
                            buildWhen: (previous, current) => current is ShippingGetSuccess,
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, left: 40),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: BlocBuilder(
                                      builder: (context, state) {
                                        if (state is ProfileGetSuccess) {
                                          return _Address(
                                            editMode: _editAddress,
                                            beginAddress: state.user.address ?? '',
                                            addressCtrl: _addressCtrl,
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      bloc: AppBloc.profileBloc,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Text(
                                    AppLocalizations.t(context, 'change'),
                                    style: TextStyle(
                                      color: AppColor.red593B,
                                      fontSize: 12,
                                      fontFamily: AppFont.monospace,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _editAddress = !_editAddress;
                                    });
                                  },
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColor.rBMain)),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: AppColor.rBMain)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.t(context, 'paymentMethod'),
                                style: _TextStyleMono(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: METHOD_PAY_PAL,
                                groupValue: _method,
                                onChanged: (T) {
                                  setState(() {
                                    _method = METHOD_PAY_PAL;
                                  });
                                },
                              ),
                              Text(
                                "PayPal",
                                style: _TextStyleMono(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: METHOD_CREDIT_CARD,
                                groupValue: _method,
                                onChanged: (T) {
                                  setState(() {
                                    _method = METHOD_CREDIT_CARD;
                                  });
                                },
                              ),
                              Text(
                                'VISA / Master ' + AppLocalizations.t(context, 'creditCard'),
                                style: _TextStyleMono(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: METHOD_STORE_PAYMENT,
                                groupValue: _method,
                                onChanged: (T) {
                                  setState(() {
                                    _method = METHOD_STORE_PAYMENT;
                                  });
                                },
                              ),
                              Text(
                                AppLocalizations.t(context, 'cash'),
                                style: _TextStyleMono(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    BlocConsumer(
                      builder: (context, state) {
                        if (state is CheckoutConfirmLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Align(
                            child: InkWell(
                              radius: 30,
                              onTap: () {
                                if (_method == METHOD_CREDIT_CARD) {
                                  if (creditState is CreditCardOneSuccess) {
                                    pressCheckOut();
                                  } else {
                                    Navigator.pushNamed(context, AppRoute.creditAdd);
                                  }
                                } else {
                                  pressCheckOut();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: AppColor.pinkLight,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Text(
                                  AppLocalizations.t(context, 'confirmPayment'),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                        );
                      },
                      listener: (context, state) {
                        if (state is CheckoutConfirmSuccess) {
                          AppBloc.cartBloc.add(CartGet());
                          Navigator.pushNamed(
                            context,
                            AppRoute.pay,
                            arguments: {'link': state.checkoutLink},
                          );
                        }
                      },
                      bloc: AppBloc.checkoutBloc,
                    ),
                  ],
                );
              },
              bloc: AppBloc.creditCardBloc,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        bloc: AppBloc.cartBloc,
      ),
    );
  }

  Widget coupon() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        /*Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              SizedBox(
                child: Text(AppLocalizations.t(context, 'points') + '(300):'),
                width: 100,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '50',
                  style: TextStyle(color: AppColor.whiteMain),
                ),
                decoration: BoxDecoration(color: AppColor.rBMain),
              ),
            ],
          ),
        ),*/
        Row(
          children: [
            SizedBox(
              child: Text(AppLocalizations.t(context, 'promo')),
              width: 100,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(right: 20),
              child: Text(
                couponName ?? '-',
                style: TextStyle(color: AppColor.whiteMain),
              ),
              decoration: BoxDecoration(color: AppColor.rBMain),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              child: Text(
                AppLocalizations.t(context, 'change'),
                style: TextStyle(
                  color: AppColor.red593B,
                  fontSize: 12,
                  fontFamily: AppFont.monospace,
                ),
              ),
              onTap: () async {
                AppBloc.couponBloc.add(CouponGetAll());
                final result = await Navigator.pushNamed(context, AppRoute.coupon);
                List coupon = result.toString().split('-');
                setState(() {
                  couponId = int.parse(coupon[0]);
                  couponName = coupon[1];
                  couponValue = coupon[2];
                });
              },
            ),
          ],
        )
      ],
      direction: Axis.vertical,
    );
  }

  Widget discount() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.t(context, 'shippingFee')),
              Text('\$' + shippingFee!),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(AppLocalizations.t(context, 'promo')), Text('- \$' + couponValue!)],
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColor.rBMain)),
          ),
        ),
      ],
    );
  }

  void pressCheckOut() {
    if (_delivery == DELIVERY_YOUR_DOOR && _addressCtrl.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please input shipping address',
        backgroundColor: AppColor.pinkLight,
        textColor: AppColor.redMain,
        timeInSecForIosWeb: 2,
      );
    } else {
      AppBloc.checkoutBloc.add(
        CheckoutConfirm(
          address: _addressCtrl.text,
          delivery: _delivery,
          method: _method,
          fee: fee,
          coupon: couponId,
        ),
      );
    }
  }
}

class _Item extends StatelessWidget {
  final List<Product> products;

  _Item({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: products.map((e) {
          return Row(
            children: [
              SizedBox(
                child: Text(e.name, style: _TextStyleMono()),
                width: 120,
              ),
              Text(
                "${e.inCart}",
                style: _TextStyleMadeByTommy(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "\$${e.amount}",
                      style: _TextStyleMadeByTommy(),
                    ),
                  ],
                ),
              )
            ],
          );
        }).toList(),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.rBMain)),
      ),
    );
  }
}

class _Address extends StatefulWidget {
  final bool editMode;
  final String beginAddress;
  final TextEditingController addressCtrl;

  _Address({
    Key? key,
    required this.editMode,
    required this.beginAddress,
    required this.addressCtrl,
  }) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<_Address> {
  @override
  void initState() {
    widget.addressCtrl.text = widget.beginAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.editMode ? 40 : 20,
      margin: EdgeInsets.only(right: 10),
      child: TextField(
        textAlign: widget.editMode ? TextAlign.center : TextAlign.left,
        style: _TextStyleMadeByTommy(),
        controller: widget.addressCtrl,
        enabled: widget.editMode,
        decoration: InputDecoration(
          contentPadding: widget.editMode ? EdgeInsets.symmetric(horizontal: 10) : EdgeInsets.zero,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.pinkLight,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.pinkLight,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _Coupon extends StatelessWidget {
  const _Coupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              SizedBox(
                child: Text(AppLocalizations.t(context, 'points') + '(300):'),
                width: 100,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '50',
                  style: TextStyle(color: AppColor.whiteMain),
                ),
                decoration: BoxDecoration(color: AppColor.rBMain),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              child: Text(AppLocalizations.t(context, 'promo')),
              width: 100,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(right: 20),
              child: Text(
                'DF3D',
                style: TextStyle(color: AppColor.whiteMain),
              ),
              decoration: BoxDecoration(color: AppColor.rBMain),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              child: Text(
                AppLocalizations.t(context, 'change'),
                style: TextStyle(
                  color: AppColor.red593B,
                  fontSize: 12,
                  fontFamily: AppFont.monospace,
                ),
              ),
              onTap: () async {
                AppBloc.couponBloc.add(CouponGetAll());
                final id = await Navigator.pushNamed(context, AppRoute.coupon);
              },
            ),
          ],
        )
      ],
      direction: Axis.vertical,
    );
  }
}

class _Discount extends StatelessWidget {
  const _Discount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SizedBox(
                child: Text(AppLocalizations.t(context, 'shipping')),
                width: 120,
              ),
              Text('送到上門'),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('\$0.00'),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColor.rBMain)),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(AppLocalizations.t(context, 'pointDiscount')),
                      width: 120,
                    ),
                  ),
                  Text('-\$50.00')
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(AppLocalizations.t(context, 'promo')),
                      width: 120,
                    ),
                  ),
                  Text('0%')
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColor.rBMain)),
          ),
        ),
      ],
      direction: Axis.vertical,
    );
  }
}

class _TextStyleMono extends TextStyle {
  _TextStyleMono()
      : super(
          fontFamily: AppFont.monospace,
          fontWeight: AppFont.wMedium,
          fontSize: 15,
          color: AppColor.rBMain,
        );
}

class _TextStyleMadeByTommy extends TextStyle {
  _TextStyleMadeByTommy()
      : super(
          fontFamily: AppFont.madeTommySoft,
          fontWeight: AppFont.wMedium,
          fontSize: 15,
          color: AppColor.rBMain,
        );
}
