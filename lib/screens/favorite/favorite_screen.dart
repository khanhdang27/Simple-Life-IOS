import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/checkbox.dart' as MyCheckBox;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_list_with_horizontal_item.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen() {
    AppBloc.favoriteCheckBloc.add(FavoriteCheckAll(value: true));
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.titleBg),
                fit: BoxFit.fill,
              ),
            ),
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 10),
                  child: Icon(
                    AppIcon.heart,
                    size: 22,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppFont.monospace,
                    fontWeight: AppFont.wBold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
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
                            builder: (context, FavoriteCheckState state) {
                              bool _checkValue = false;
                              if (state is FavoriteCheckAllSuccess) {
                                _checkValue = state.value;
                              }
                              return MyCheckBox.Checkbox(
                                value: _checkValue,
                                onChanged: (value) {
                                  AppBloc.favoriteCheckBloc.add(
                                    FavoriteCheckAll(value: value!),
                                  );
                                },
                              );
                            },
                            bloc: AppBloc.favoriteCheckBloc,
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
                      AppBloc.favoriteBloc.add(FavoriteMultipleRemove());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
