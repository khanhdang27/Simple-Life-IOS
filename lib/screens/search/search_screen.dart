import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/components.dart';
import 'package:baseproject/screens/components/dropdown.dart' as MyDropdown;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_input.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchCtrl;
  String sortDefault = 'up_to_date';

  @override
  void initState() {
    _searchCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 20),
          child: BlocBuilder(
            builder: (context, state) {
              bool condition = true;
              if (state is SearchGetSuccess && state.keyword != null) {
                _searchCtrl.text = state.keyword!;
                condition = false;
              }
              return SearchInput(
                hint: condition,
                controller: _searchCtrl,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    AppBloc.searchBloc.add(SearchGet(keyword: value));
                  }
                },
              );
            },
            bloc: AppBloc.searchBloc,
          ),
        ),
        BlocBuilder(
          builder: (context, state) {
            if (state is SearchGetSuccess) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '彩妝',
                            style: TextStyle(
                              fontFamily: AppFont.monospace,
                              fontWeight: AppFont.wMedium,
                              fontSize: 24,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("共${state.products.length}件"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.end,
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            AppLocalizations.t(context, 'sort'),
                            style: TextStyle(
                              fontFamily: AppFont.monospace,
                              fontWeight: AppFont.wMedium,
                              fontSize: 24,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: DropdownInput(
                              onChange: (value) {
                                setState(() {
                                  sortDefault = value;
                                });
                                AppBloc.searchBloc.add(SearchSort(type: value));
                              },
                              value: sortDefault,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox();
          },
          bloc: AppBloc.searchBloc,
        ),
        BlocBuilder(
          builder: (context, state) {
            if (state is SearchGetSuccess) {
              return ProductGrid(
                childAspectRatio: 293.91 / 484.95,
                maxCrossAxisExtent: 293.91,
                products: state.products,
              );
            }
            if (state is SearchLoading) {
              sortDefault = 'up_to_date';
              return Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return SizedBox();
          },
          bloc: AppBloc.searchBloc,
        )
      ],
    );
  }
}

class DropdownInput extends StatefulWidget {
  final String value;
  final ValueChanged onChange;

  const DropdownInput({
    Key? key,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  List items = [
    ['up_to_date', 'upToDate'],
    ['high_to_low', 'highToLow'],
    ['low_to_high', 'lowToHigh'],
    ['evaluation', 'evaluation']
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: MyDropdown.DropdownButtonHideUnderline(
        child: MyDropdown.DropdownButton(
          dropdownColor: AppColor.pinkDropdown,
          icon: Container(
            color: AppColor.rBMain,
            child: Icon(
              Icons.arrow_drop_down,
              color: AppColor.whiteMain,
            ),
          ),
          items: items.map((e) {
            return MyDropdown.DropdownMenuItem(
              value: e[0],
              child: Container(
                color: widget.value == e[0] ? AppColor.pinkDropdownFocus : null,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.t(context, e[1]),
                        style: TextStyle(
                          color: AppColor.rBMain,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return items.map((item) {
              return Container(
                width: 50,
                padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.rBMain),
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    AppLocalizations.t(context, item[1]),
                    style: TextStyle(color: AppColor.rBMain, fontSize: 10),
                  ),
                ),
              );
            }).toList();
          },
          onChanged: widget.onChange,
          value: widget.value,
        ),
      ),
    );
  }
}
