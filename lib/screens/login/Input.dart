import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final TextEditingController txtController;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final ValueChanged<String>? onSubmitted;

  Input({
    this.obscureText = false,
    required this.txtController,
    required this.label,
    this.keyboardType,
    this.errorText,
    this.onSubmitted,
  });

  @override
  State<StatefulWidget> createState() {
    return _InputState();
  }
}

class _InputState extends State<Input> {
  late FocusNode _focusNode;
  bool _isFocussing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != _isFocussing) {
        setState(() {
          _isFocussing = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.txtController,
      obscureText: widget.obscureText,
      cursorColor: AppColor.rBMain,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        color: AppColor.blackContent,
        fontWeight: AppFont.wMedium,
        fontSize: 25,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontFamily: AppFont.madeTommySoft,
          fontWeight: AppFont.wLight,
          fontSize: 20.24,
          color: _isFocussing ? AppColor.rBMain : AppColor.blackContent,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.brownBorder,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.rBMain,
          ),
        ),
        errorText: widget.errorText ?? null,
      ),
      onSubmitted: widget.onSubmitted,
    );
  }
}
