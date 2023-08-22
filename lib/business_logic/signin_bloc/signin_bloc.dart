import 'package:bloc/bloc.dart';
import 'package:bloctask/data/enums/signin_enum.dart';
import 'package:bloctask/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/firebase_helper.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninState()) {
    on<OnEmailChange>(_emailChange);
    on<OnPasswordChange>(_passwordChange);
    on<OnSignIn>(_signIn);
  }

  void _emailChange(OnEmailChange event, Emitter<SigninState> emit) {
    final newEmail = event.email;
    emit(state.copyWith(email: newEmail, signinStatus: SigninStatus.none));
  }

  void _passwordChange(OnPasswordChange event, Emitter<SigninState> emit) {
    final newPassword = event.password;
    emit(
        state.copyWith(password: newPassword, signinStatus: SigninStatus.none));
  }

  void _signIn(OnSignIn event, Emitter<SigninState> emit) async {
    FirebaseHelper firebaseHelper = FirebaseHelper();
    emit(state.copyWith(signinStatus: SigninStatus.loading));
    try {
      await firebaseHelper.signInWithEmailPassword(state.email, state.password);

      emit(state.copyWith(
          email: "", password: "", signinStatus: SigninStatus.success));
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(
            state.copyWith(signinStatus: SigninStatus.error, error: e.message));
        await Future.delayed(Duration(seconds: 3), () {
          emit(state.copyWith(signinStatus: SigninStatus.none));
        });
      }
    }
  }
}
