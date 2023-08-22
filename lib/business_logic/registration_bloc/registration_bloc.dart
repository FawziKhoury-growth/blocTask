import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/enums/registration_enum.dart';
import '../../data/repository/firebase_helper.dart';
import 'package:bloctask/data/enums/registration_enum.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationState()) {
    on<OnFirstNameChange>(_firstNameChange);
    on<OnLastNameChange>(_lastNameChange);
    on<OnEmailChange>(_emailChange);
    on<OnPasswordChange>(_passwordChange);
    on<OnButtonClicked>(_buttonClicked);
    on<OnClearEvent>(_clearEvent);
  }

  void _firstNameChange(
      OnFirstNameChange event, Emitter<RegistrationState> emit) {
    final newFirstName = event.firstName;
    emit(state.copyWith(
        firstName: newFirstName, registrationStatus: RegistrationStatus.none));
  }

  void _lastNameChange(
      OnLastNameChange event, Emitter<RegistrationState> emit) {
    final newLastName = event.lastName;
    emit(state.copyWith(
        lastName: newLastName, registrationStatus: RegistrationStatus.none));
  }

  void _emailChange(OnEmailChange event, Emitter<RegistrationState> emit) {
    final newEmail = event.email;
    emit(state.copyWith(
        email: newEmail, registrationStatus: RegistrationStatus.none));
  }

  void _passwordChange(
      OnPasswordChange event, Emitter<RegistrationState> emit) {
    final newPassword = event.password;
    emit(state.copyWith(
        password: newPassword, registrationStatus: RegistrationStatus.none));
  }

  void _buttonClicked(
      OnButtonClicked event, Emitter<RegistrationState> emit) async {
    FirebaseHelper firebaseHelper = FirebaseHelper();
    emit(state.copyWith(registrationStatus: RegistrationStatus.loading));
    try {
      String uid = await firebaseHelper.signUpWithEmailPassword(
          state.firstName, state.lastName, state.email, state.password);

      emit(state.copyWith(
          id: uid, registrationStatus: RegistrationStatus.success));
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(state.copyWith(
            registrationStatus: RegistrationStatus.error, error: e.message));
        await Future.delayed(Duration(seconds: 3), () {
          emit(state.copyWith(registrationStatus: RegistrationStatus.none));
        });
      }
    }
  }

  void _clearEvent(OnClearEvent event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(firstName: "", lastName: "", email: "", password: ""));
  }
}
