// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_bloc.dart';

@immutable
class RegistrationState extends Equatable {
  final RegistrationStatus registrationStatus;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String error;

  const RegistrationState(
      {this.registrationStatus = RegistrationStatus.none,
      this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.email = "",
      this.password = "",
      this.error = ""});

  @override
  List<Object> get props =>
      [registrationStatus, id, firstName, lastName, email, password, error];

  RegistrationState copyWith({
    RegistrationStatus? registrationStatus,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? error,
  }) {
    return RegistrationState(
      registrationStatus: registrationStatus ?? this.registrationStatus,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
