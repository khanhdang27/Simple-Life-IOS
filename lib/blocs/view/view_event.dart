part of 'view_bloc.dart';

@immutable
abstract class ViewEvent {}

class ViewHome extends ViewEvent {}

class ViewCategory extends ViewEvent {}
