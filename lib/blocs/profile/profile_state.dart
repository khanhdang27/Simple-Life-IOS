part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileGetSuccess extends ProfileState {
  final User user;

  ProfileGetSuccess({required this.user});
}
