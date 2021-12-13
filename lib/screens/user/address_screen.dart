import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressScreen extends StatefulWidget {
  final String? address;

  const AddressScreen({Key? key, this.address}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _addressCtrl = TextEditingController();

  @override
  void initState() {
    if (widget.address != null) {
      _addressCtrl.text = widget.address!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        if (state is UserAddressRequestSuccess) {
          AppBloc.profileBloc.add(ProfileGet());
          Navigator.pop(context);
        }
      },
      bloc: AppBloc.userAddressBloc,
      builder: (BuildContext context, state) {
        String? error;
        if (state is UserAddressRequestFailed) {
          error = state.errors['address'];
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _addressCtrl,
                maxLines: 5,
                style: TextStyle(
                  color: AppColor.blackContent,
                  fontWeight: AppFont.wMedium,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  errorText: error,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.yellowLight),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.pinkLight),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.pinkLight),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  onTap: () {
                    if (_addressCtrl.text.isNotEmpty) {
                      AppBloc.userAddressBloc.add(UserAddressRequest(
                        address: _addressCtrl.text,
                      ));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    decoration: BoxDecoration(
                      color: AppColor.pinkLight,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
