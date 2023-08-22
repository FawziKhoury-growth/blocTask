// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'guest_room_bloc.dart';

sealed class GuestRoomEvent extends Equatable {
  const GuestRoomEvent();

  @override
  List<Object> get props => [];
}

class OnIncreamentAdultEvent extends GuestRoomEvent {
  const OnIncreamentAdultEvent();
  @override
  List<Object> get props => [];
}

class OnDecreamentAdultEvent extends GuestRoomEvent {
  const OnDecreamentAdultEvent();
  @override
  List<Object> get props => [];
}

class OnIncreamentChildEvent extends GuestRoomEvent {
  const OnIncreamentChildEvent();
  @override
  List<Object> get props => [];
}

class OnDecreamentChildEvent extends GuestRoomEvent {
  const OnDecreamentChildEvent();
  @override
  List<Object> get props => [];
}

class OnChangeChildAgeEvent extends GuestRoomEvent {
  final int index;
  final int age;
  OnChangeChildAgeEvent({
    required this.index,
    required this.age,
  });
  @override
  List<Object> get props => [index, age];
}

class OnClearEvent extends GuestRoomEvent {
  const OnClearEvent();
  @override
  List<Object> get props => [];
}
