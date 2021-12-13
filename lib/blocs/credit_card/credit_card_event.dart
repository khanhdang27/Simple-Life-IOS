part of 'credit_card_bloc.dart';

@immutable
abstract class CreditCardEvent {}

class CreditCardOne extends CreditCardEvent {}

class CreditCardAdd extends CreditCardEvent {
  final String number;
  final String expMonth;
  final String expYear;
  final String cvc;

  CreditCardAdd({
    required this.number,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
  });
}

class CreditCardRemove extends CreditCardEvent {}

class CreditCardEdit extends CreditCardEvent {
  final String expMonth;
  final String expYear;

  CreditCardEdit({
    required this.expMonth,
    required this.expYear,
  });
}
