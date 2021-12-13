import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged onSubmitted;
  final bool hint;

  const SearchInput({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    this.hint = true,
  }) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        color: AppColor.blackContent,
        fontWeight: AppFont.wMedium,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.rBMain, width: 2),
          borderRadius: const BorderRadius.all(
            const Radius.circular(25),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.rBMain, width: 2),
          borderRadius: const BorderRadius.all(
            const Radius.circular(25),
          ),
        ),
        contentPadding: EdgeInsets.only(left: 10, right: 10),
        hintText: widget.hint ? 'Search' : null,
        hintStyle: TextStyle(
          fontSize: 16,
          color: AppColor.rBMain,
          fontFamily: AppFont.madeTommySoft,
          fontWeight: AppFont.wMedium,
        ),
        prefixIcon: Icon(
          AppIcon.search,
          size: 20,
          color: AppColor.rBMain,
        ),
      ),
    );
  }
}
