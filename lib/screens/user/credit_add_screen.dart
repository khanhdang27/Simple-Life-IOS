import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreditAddScreen extends StatefulWidget {
  bool back = false;

  @override
  _CreditAddScreenState createState() => _CreditAddScreenState();
}

class _CreditAddScreenState extends State<CreditAddScreen> {
  TextEditingController cardController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  var maskCode = new MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  var maskExpiry = new MaskTextInputFormatter(
    mask: '##/##',
    filter: {
      "#": RegExp(r"([0-9])"),
    },
  );
  var maskCVV = new MaskTextInputFormatter(
    mask: '######',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 90),
            decoration: BoxDecoration(
              color: AppColor.pinkLight,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
            ),
            child: Column(
              children: [
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: Row(
              children: [
                SizedBox(
                  child: Text(
                    'Card Number:',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.rBMain,
                      fontWeight: AppFont.wMedium,
                      fontFamily: AppFont.madeTommySoft,
                    ),
                  ),
                  width: 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.pinkLight,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  width: 230,
                  height: 35,
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: cardController,
                    inputFormatters: [maskCode],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.rBMain,
                      fontWeight: AppFont.wMedium,
                      fontFamily: AppFont.madeTommySoft,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Row(
              children: [
                SizedBox(
                  child: Text(
                    'Expiry:',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.rBMain,
                      fontWeight: AppFont.wMedium,
                      fontFamily: AppFont.madeTommySoft,
                    ),
                  ),
                  width: 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.pinkLight,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  width: 100,
                  height: 35,
                  padding: EdgeInsets.only(bottom: 5),
                  margin: EdgeInsets.only(right: 10),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: expiryController,
                    inputFormatters: [maskExpiry],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.rBMain,
                      fontWeight: AppFont.wMedium,
                      fontFamily: AppFont.madeTommySoft,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today_outlined),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Row(
              children: [
                SizedBox(
                  child: Text('CVC:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: AppFont.wMedium,
                        fontFamily: AppFont.madeTommySoft,
                      )),
                  width: 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.pinkLight,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  width: 150,
                  height: 35,
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: cvvController,
                    inputFormatters: [maskCVV],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.rBMain,
                      fontFamily: AppFont.madeTommySoft,
                      fontWeight: AppFont.wMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: BlocConsumer(
              builder: (context, state) {
                if (state is CreditCardLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return InkWell(
                  radius: 30,
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    if (cardController.text.isNotEmpty &&
                        expiryController.text.isNotEmpty &&
                        cvvController.text.isNotEmpty) {
                      List exp = expiryController.text.split('/');
                      if (exp.length == 2) {
                        String month = exp[0];
                        String year = exp[1];
                        AppBloc.creditCardBloc.add(CreditCardAdd(
                          number: cardController.text,
                          expMonth: month,
                          expYear: year,
                          cvc: cvvController.text,
                        ));
                      }
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
                      AppLocalizations.t(context, 'add'),
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
              listener: (context, state) {
                if (state is CreditCardOneSuccess) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
