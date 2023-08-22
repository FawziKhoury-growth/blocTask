// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

class SigninState extends Equatable {
  final SigninStatus signinStatus;
  final String email;
  final String password;
  final String error;

  const SigninState({
    this.signinStatus = SigninStatus.none,
    this.email = "",
    this.password = "",
    this.error = "",
  });

  @override
  List<Object> get props => [signinStatus, email, password, error];

  SigninState copyWith({
    SigninStatus? signinStatus,
    String? email,
    String? password,
    String? error,
  }) {
    return SigninState(
      signinStatus: signinStatus ?? this.signinStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
