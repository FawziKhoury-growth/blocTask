import 'package:bloc/bloc.dart';
import 'package:bloctask/data/enums/authentication_enum.dart';
import 'package:bloctask/data/models/user_model.dart';
import 'package:bloctask/data/repository/firebase_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    on<OnUpdateCurrentUser>(_updateCurrentUser);
    on<OnSetCurrentUser>(_setCurrentUser);
    on<OnSignOut>(_signOut);
  }

  void _updateCurrentUser(
      OnUpdateCurrentUser event, Emitter<AuthenticationState> emit) async {
    UserModel newCurrentUser = event.user;

    emit(state.copyWith(
        currentUser: newCurrentUser,
        authenticationStatus: AuthenticationStatus.authenticated));
  }

  void _setCurrentUser(
      OnSetCurrentUser event, Emitter<AuthenticationState> emit) async {
    FirebaseHelper firebaseHelper = FirebaseHelper();

    UserModel? newCurrentUser = await firebaseHelper.checkUser();

    if (newCurrentUser == null) {
      emit(state.copyWith(
          currentUser: newCurrentUser,
          authenticationStatus: AuthenticationStatus.unauthenticated));
    } else {
      emit(state.copyWith(
          currentUser: newCurrentUser,
          authenticationStatus: AuthenticationStatus.authenticated));
    }
  }

  void _signOut(OnSignOut event, Emitter<AuthenticationState> emit) async {
    FirebaseHelper firebaseHelper = FirebaseHelper();

    try {
      await firebaseHelper.signOutUser();
      emit(state.copyWith(
          currentUser: UserModel.empty,
          authenticationStatus: AuthenticationStatus.unauthenticated));
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(
            state.copyWith(authenticationStatus: AuthenticationStatus.unknown));
      }
    }
  }
}
