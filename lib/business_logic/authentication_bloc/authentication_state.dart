// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final UserModel currentUser;
  final AuthenticationStatus authenticationStatus;
  const AuthenticationState(
      {this.currentUser = UserModel.empty,
      this.authenticationStatus = AuthenticationStatus.unknown});

  @override
  List<Object> get props => [currentUser, authenticationStatus];

  AuthenticationState copyWith(
      {UserModel? currentUser, AuthenticationStatus? authenticationStatus}) {
    return AuthenticationState(
        currentUser: currentUser ?? this.currentUser,
        authenticationStatus:
            authenticationStatus ?? this.authenticationStatus);
  }
}
