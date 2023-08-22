// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class OnEmailChange extends SigninEvent {
  final String email;
  OnEmailChange({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class OnPasswordChange extends SigninEvent {
  final String password;
  OnPasswordChange({
    required this.password,
  });

  @override
  List<Object> get props => [password];
}

class OnSignIn extends SigninEvent {
  const OnSignIn();
  @override
  List<Object> get props => [];
}
