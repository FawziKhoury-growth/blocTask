import 'package:bloc/bloc.dart';
import 'package:bloctask/data/enums/guest_room_enum.dart';
import 'package:equatable/equatable.dart';

part 'guest_room_event.dart';
part 'guest_room_state.dart';

class GuestRoomBloc extends Bloc<GuestRoomEvent, GuestRoomState> {
  GuestRoomBloc() : super(GuestRoomState()) {
    on<OnIncreamentAdultEvent>(_incrementAdult);
    on<OnDecreamentAdultEvent>(_decreamentAdult);
    on<OnIncreamentChildEvent>(_incrementChild);
    on<OnDecreamentChildEvent>(_decreamentChild);
    on<OnChangeChildAgeEvent>(_changeChildAge);
    on<OnClearEvent>(_clearAll);
  }

  void _incrementAdult(
      OnIncreamentAdultEvent event, Emitter<GuestRoomState> emit) {
    emit(state.copyWith(
      adultCounter: state.adultCounter + 1,
    ));
    emit(state.copyWith(guestRoomStatus: getGuestRoomStatus()));
  }

  void _decreamentAdult(
      OnDecreamentAdultEvent event, Emitter<GuestRoomState> emit) {
    if (state.adultCounter > 0) {
      emit(state.copyWith(
        adultCounter: state.adultCounter - 1,
      ));
      emit(state.copyWith(guestRoomStatus: getGuestRoomStatus()));
    }
  }

  void _incrementChild(
      OnIncreamentChildEvent event, Emitter<GuestRoomState> emit) {
    List<int> updateList = [...state.childrenAge];
    updateList.add(0);
    emit(state.copyWith(
      childrenCounter: state.childrenCounter + 1,
      childrenAge: updateList,
    ));
    emit(state.copyWith(guestRoomStatus: getGuestRoomStatus()));
  }

  void _decreamentChild(
      OnDecreamentChildEvent event, Emitter<GuestRoomState> emit) {
    List<int> updateList = [...state.childrenAge];

    if (state.childrenCounter > 0) {
      updateList.removeLast();
      emit(state.copyWith(
        childrenCounter: state.childrenCounter - 1,
        childrenAge: updateList,
      ));
      emit(state.copyWith(guestRoomStatus: getGuestRoomStatus()));
    }
  }

  void _changeChildAge(
      OnChangeChildAgeEvent event, Emitter<GuestRoomState> emit) {
    List<int> updateList = [...state.childrenAge];
    updateList[event.index] = event.age;
    emit(state.copyWith(childrenAge: updateList));
    emit(state.copyWith(guestRoomStatus: getGuestRoomStatus()));
  }

  void _clearAll(OnClearEvent event, Emitter<GuestRoomState> emit) {
    emit(state.copyWith(
      adultCounter: 0,
      childrenCounter: 0,
      childrenAge: List.empty(),
    ));
    emit(state.copyWith(guestRoomStatus: getGuestRoomStatus()));
  }

  GuestRoomStatus getGuestRoomStatus() {
    if (state.childrenCounter > 0 &&
        state.childrenAge.where((element) => element == 0).toList().length >
            0) {
      return GuestRoomStatus.notChecked;
    } else if (state.childrenCounter == 0 && state.adultCounter == 0) {
      return GuestRoomStatus.notChecked;
    } else {
      return GuestRoomStatus.success;
    }
  }
}
