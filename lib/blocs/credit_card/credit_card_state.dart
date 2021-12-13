part of 'credit_card_bloc.dart';

@immutable
abstract class CreditCardState {}

class CreditCardInitial extends CreditCardState {}

class CreditCardLoading extends CreditCardState {}

class CreditCardOneSuccess extends CreditCardState {
  final CreditCard card;

  CreditCardOneSuccess({required this.card});
}

class CreditCardRemoveSuccess extends CreditCardState {}

class CreditCardFail extends CreditCardState {}
