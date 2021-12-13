part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderGet extends OrderEvent {}
