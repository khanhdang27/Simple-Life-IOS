import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/checkbox.dart' as MyCheckBox;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_list_with_horizontal_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    AppBloc.cartCheckBloc.add(CartCheckAll(value: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _Title(title: AppLocalizations.t(context, "hotDeals")),
          ProductWithHorizontalItem(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: BlocBuilder(
                          builder: (context, CartCheckState state) {
                            bool _checkValue = false;
                            if (state is CartCheckAllSuccess) {
                              _checkValue = state.value;
                            }
                            return MyCheckBox.Checkbox(
                              value: _checkValue,
                              onChanged: (value) {
                                AppBloc.cartCheckBloc.add(
                                  CartCheckAll(value: value!),
                                );
                              },
                            );
                          },
                          bloc: AppBloc.cartCheckBloc,
                        ),
                      ),
                      Text(
                        "全選",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.monospace,
                          fontWeight: AppFont.wBold,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.delete),
                      Text(
                        "移除",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.monospace,
                          fontWeight: AppFont.wBold,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    AppBloc.cartBloc.add(CartMultipleRemove());
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
