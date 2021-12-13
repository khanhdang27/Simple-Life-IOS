import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/dropdown.dart' as MyDropdown;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _notice = true;
  bool _editMode = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  late Locale languageDefault;
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  @override
  void initState() {
    languageDefault = AppLanguage.selectedLanguage;
    AppBloc.profileBloc.add(ProfileGet());
    super.initState();
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder(
        bloc: AppBloc.profileBloc,
        buildWhen: (previous, current) {
          return current is ProfileGetSuccess;
        },
        builder: (context, state) {
          return BlocBuilder(
            builder: (context, stateUser) {
              if (state is ProfileGetSuccess) {
                if (stateUser is UpdateProfileFailed) {
                  Fluttertoast.showToast(msg: stateUser.errors!['phone'],timeInSecForIosWeb: 2);
                  AppBloc.userBloc.add(UserReset());
                }
                phoneCtrl.text = state.user.phone ?? '';
                nameCtrl.text = state.user.name;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 165,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAsset.setting),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 20,
                                  left: 15,
                                  bottom: 25,
                                  top: 5,
                                ),
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteMain,
                                  border: Border.all(color: AppColor.whiteMain, width: 5),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  height: 85,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(AppAsset.cateMen),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_editMode) {
                                        if (nameCtrl.text != state.user.name ||
                                            phoneCtrl.text != state.user.phone) {
                                          AppBloc.userBloc.add(UpdateProfile(
                                              phone: phoneCtrl.text, name: nameCtrl.text));
                                        }
                                      }
                                      _editMode = !_editMode;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 3,
                                      right: 6,
                                      left: 3,
                                      bottom: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.pinkLight,
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          child: Icon(
                                            _editMode ? Icons.save : Icons.mode_edit,
                                            size: 15,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.t(
                                            context,
                                            'editProfile',
                                          ),
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.rBMain),
                      )),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: _InfoText(
                              text: AppLocalizations.t(context, 'name'),
                            ),
                          ),
                          FormEdit(
                            controller: nameCtrl,
                            editMode: AppSharedPrefs.getLoginType() == AppSharedPrefs.loginExternal
                                ? _editMode
                                : false,
                            onSubmit: (value) {
                              setState(() {
                                _editMode = false;
                              });
                              if (value != state.user.name || phoneCtrl.text != state.user.phone) {
                                AppBloc.userBloc
                                    .add(UpdateProfile(phone: phoneCtrl.text, name: nameCtrl.text));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.rBMain),
                      )),
                      child: Row(
                        children: [
                          Icon(Icons.mail_sharp),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: _InfoText(text: AppLocalizations.t(context, 'e-mail')),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 150,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      "${state.user.email}",
                                      style: _TextStyle(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.rBMain),
                      )),
                      child: Row(
                        children: [
                          Icon(Icons.phone),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: _InfoText(
                              text: AppLocalizations.t(context, 'phone'),
                            ),
                          ),
                          FormEdit(
                            controller: phoneCtrl,
                            editMode: AppSharedPrefs.getLoginType() == AppSharedPrefs.loginExternal
                                ? _editMode
                                : false,
                            onSubmit: (value) {
                              setState(() {
                                _editMode = false;
                              });
                              if (value != state.user.phone || nameCtrl.text != state.user.name) {
                                AppBloc.userBloc
                                    .add(UpdateProfile(phone: phoneCtrl.text, name: nameCtrl.text));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.rBMain),
                      )),
                      child: Row(
                        children: [
                          Icon(Icons.all_inbox),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: _InfoText(
                              text: AppLocalizations.t(context, 'discountPoint'),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Text('0', style: _TextStyle())],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          Icon(Icons.home_work_outlined),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: _InfoText(
                              text: AppLocalizations.t(context, 'address'),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 150,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: state.user.address != null
                                        ? Text(
                                            "${state.user.address}",
                                            style: _TextStyle(),
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.address,
                                arguments: {'address': state.user.address},
                              );
                            },
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Text(
                              AppLocalizations.t(context, 'change'),
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.red593B,
                                fontFamily: AppFont.monospace,
                                fontWeight: AppFont.wBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                      child: _InfoText(text: AppLocalizations.t(context, 'setting')),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.rBMain),
                      )),
                      child: Row(
                        children: [
                          _InfoText(text: AppLocalizations.t(context, 'language')),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _DropdownInput(
                                  onChange: (value) {
                                    AppBloc.languageBloc.add(LanguageSelect(
                                      language: value,
                                    ));
                                    setState(() {
                                      languageDefault = value;
                                    });
                                  },
                                  value: languageDefault,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.rBMain),
                      )),
                      child: Row(
                        children: [
                          _InfoText(text: AppLocalizations.t(context, 'notice')),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Switch(
                                  value: _notice,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _notice = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          _InfoText(
                            text: AppLocalizations.t(context, 'creditCardInfo'),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRoute.credit);
                                  },
                                  child: Icon(Icons.credit_card),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          _InfoText(
                            text: AppLocalizations.t(context, 'share'),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.share),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: InkWell(
                        onTap: () {
                          if (AppSharedPrefs.getLoginType() == AppSharedPrefs.loginInternal) {
                            Navigator.pushNamed(context, AppRoute.changePass);
                          } else {
                            Fluttertoast.showToast(
                                msg: AppLocalizations.t(context, 'notChangePass'));
                          }
                        },
                        child: Text(
                          AppLocalizations.t(context, 'changePass'),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.red593B,
                            fontFamily: AppFont.monospace,
                            fontWeight: AppFont.wBold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            AppBloc.authBloc.add(AuthLogout());
                            _googleSignIn.signOut();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 25),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                            decoration: BoxDecoration(
                              color: AppColor.pinkLight,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
                              AppLocalizations.t(context, 'logOut'),
                              style: TextStyle(
                                fontWeight: AppFont.wMedium,
                                fontFamily: AppFont.madeTommySoft,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return SizedBox();
            },
            bloc: AppBloc.userBloc,
          );
        },
      ),
    );
  }
}

class _DropdownInput extends StatefulWidget {
  final Locale value;
  final ValueChanged onChange;

  const _DropdownInput({
    Key? key,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<_DropdownInput> {
  List items = [
    [Locale('zh'), 'chinese'],
    [Locale('en', 'US'), 'english'],
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
                height: 40,
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

class FormEdit extends StatefulWidget {
  final bool editMode;
  final ValueChanged? onSubmit;
  final TextEditingController controller;

  const FormEdit({
    Key? key,
    required this.editMode,
    required this.controller,
    this.onSubmit,
  }) : super(key: key);

  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: widget.editMode ? 40 : 20,
            width: 150,
            child: TextField(
              onSubmitted: widget.onSubmit,
              textAlign: widget.editMode ? TextAlign.center : TextAlign.right,
              style: _TextStyle(),
              controller: widget.controller,
              enabled: widget.editMode,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
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
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                errorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Name extends StatefulWidget {
  final bool editMode;
  final String name;
  final ValueChanged? onSubmit;

  const _Name({
    Key? key,
    required this.editMode,
    required this.name,
    this.onSubmit,
  }) : super(key: key);

  @override
  __NameState createState() => __NameState();
}

class __NameState extends State<_Name> {
  TextEditingController _nameCtrl = TextEditingController();

  @override
  void initState() {
    _nameCtrl.text = widget.name;
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(AppIcon.user),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: _InfoText(text: AppLocalizations.t(context, 'name')),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: widget.editMode ? 40 : 20,
                width: 150,
                child: TextField(
                  onSubmitted: widget.onSubmit,
                  textAlign: widget.editMode ? TextAlign.center : TextAlign.right,
                  style: _TextStyle(),
                  controller: _nameCtrl,
                  enabled: widget.editMode,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
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
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoText extends StatelessWidget {
  final String text;

  const _InfoText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: AppFont.wBold, fontFamily: AppFont.monospace, fontSize: 15),
    );
  }
}

class _TextStyle extends TextStyle {
  _TextStyle()
      : super(
          fontFamily: AppFont.madeTommySoft,
          fontWeight: AppFont.wRegular,
          fontSize: 15,
          color: AppColor.rBMain,
        );
}
