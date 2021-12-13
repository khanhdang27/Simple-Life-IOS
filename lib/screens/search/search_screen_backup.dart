import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/search/search_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreenBackup extends StatefulWidget {
  @override
  _SearchScreenBackupState createState() => _SearchScreenBackupState();
}

class _SearchScreenBackupState extends State<SearchScreenBackup> {
  TextEditingController _searchCtrl = TextEditingController();

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
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              SearchInput(
                controller: _searchCtrl,
                onSubmitted: (value) {
                  if (_searchCtrl.text.isNotEmpty) {
                    Navigator.pushNamed(context, AppRoute.search);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _CategoryName(categoryName: 'categoryName'),
                      _CategoryName(categoryName: 'categoryName'),
                      _CategoryName(categoryName: 'categoryName'),
                      _CategoryName(categoryName: 'categoryName'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.t(context, "searchHistory"),
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Icon(Icons.clear),
                      ),
                      Text(
                        AppLocalizations.t(context, "clearRecords"),
                        style: TextStyle(),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              _SearchHistory(content: "Noi dung"),
              _SearchHistory(content: "Noi dung"),
              _SearchHistory(content: "Noi dung"),
            ],
          ),
        )
      ],
    );
  }
}

class _CategoryName extends StatelessWidget {
  final String categoryName;

  const _CategoryName({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          categoryName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: AppFont.wRegular,
            fontFamily: AppFont.monospace,
          ),
        ),
      ),
    );
  }
}

class _SearchHistory extends StatelessWidget {
  final String content;

  const _SearchHistory({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(AppIcon.search, size: 20),
                ),
                Text(
                  content,
                  style: TextStyle(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
