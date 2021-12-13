import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/credit_card_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'credit_card_event.dart';

part 'credit_card_state.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  CreditCardBloc() : super(CreditCardInitial());
  CreditCardRepository creditCardRepository = CreditCardRepository();

  @override
  Stream<CreditCardState> mapEventToState(CreditCardEvent event) async* {
    if (event is CreditCardOne) {
      yield CreditCardLoading();
      CreditCard? card = await creditCardRepository.getOne();
      if (card != null) {
        yield CreditCardOneSuccess(card: card);
      } else {
        yield CreditCardFail();
      }
    }
    if (event is CreditCardAdd) {
      yield CreditCardLoading();
      CreditCard? card = await creditCardRepository.add(
        number: event.number,
        expMonth: event.expMonth,
        expYear: event.expYear,
        cvc: event.cvc,
      );
      if (card != null) {
        yield CreditCardOneSuccess(card: card);
      } else {
        yield CreditCardFail();
      }
    }
    if (event is CreditCardRemove) {
      yield CreditCardLoading();
      bool? deleted = await creditCardRepository.remove();
      if (deleted != null && deleted == true) {
        yield CreditCardRemoveSuccess();
      } else {
        yield CreditCardFail();
      }
    }

    if (event is CreditCardEdit) {
      yield CreditCardLoading();
      CreditCard? card = await creditCardRepository.edit(
        expMonth: event.expMonth,
        expYear: event.expYear,
      );
      if (card != null) {
        yield CreditCardOneSuccess(card: card);
      } else {
        yield CreditCardFail();
      }
    }
  }
}
