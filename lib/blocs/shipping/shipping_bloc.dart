import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  ShippingBloc() : super(ShippingInitial());
  ShippingRepository shippingRepository = ShippingRepository();

  @override
  Stream<ShippingState> mapEventToState(
    ShippingEvent event,
  ) async* {
    if(event is ShippingGet){
      Map result = await shippingRepository.getAll();
      if(result['status']==200){
        yield ShippingGetSuccess(shipping: result['shipping']);
      }else{
        yield ShippingGetFailed();
      }
    }
  }
}
