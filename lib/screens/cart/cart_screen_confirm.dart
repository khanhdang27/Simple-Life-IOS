import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_list_with_horizontal_item.dart';

class CartScreenConfirm extends StatefulWidget {
  @override
  _CartScreenConfirmState createState() => _CartScreenConfirmState();
}

class _CartScreenConfirmState extends State<CartScreenConfirm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 15, top: 20, right: 10, bottom: 0),
            child: Text(
              AppLocalizations.t(context, "confirmCard").toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontFamily: AppFont.monospace,
                fontWeight: AppFont.wMedium,
              ),
            ),
          ),
          _Title(),
          ProductWithHorizontalItem(confirm: true),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15, top: 20, right: 10, bottom: 10),
            child: BlocBuilder(
              bloc: AppBloc.cartBloc,
              builder: (context, state) {
                if (state is CartSuccess) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          "購物車共${state.quantity}件商品編輯",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFont.monospace,
                            fontWeight: AppFont.wMedium,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.edit),
                            Text(
                              "編輯",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: AppFont.monospace,
                                fontWeight: AppFont.wBold,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }
}
