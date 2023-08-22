// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class OnFirstNameChange extends RegistrationEvent {
  final String firstName;
  const OnFirstNameChange(
    this.firstName,
  );

  @override
  List<Object> get props => [firstName];
}

class OnLastNameChange extends RegistrationEvent {
  final String lastName;
  const OnLastNameChange(
    this.lastName,
  );

  @override
  List<Object> get props => [lastName];
}

class OnEmailChange extends RegistrationEvent {
  final String email;
  const OnEmailChange(
    this.email,
  );

  @override
  List<Object> get props => [email];
}

class OnPasswordChange extends RegistrationEvent {
  final String password;
  const OnPasswordChange(
    this.password,
  );

  @override
  List<Object> get props => [password];
}

class OnButtonClicked extends RegistrationEvent {
  const OnButtonClicked();
  @override
  List<Object> get props => [];
}

class OnClearEvent extends RegistrationEvent {
  const OnClearEvent();
  @override
  List<Object> get props => [];
}
