// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateCurrentUser extends AuthenticationEvent {
  final UserModel user;
  const OnUpdateCurrentUser(this.user);
  @override
  List<Object> get props => [user];
}

class OnSetCurrentUser extends AuthenticationEvent {
  const OnSetCurrentUser();
  @override
  List<Object> get props => [];
}

class OnSignOut extends AuthenticationEvent {
  const OnSignOut();
  @override
  List<Object> get props => [];
}
