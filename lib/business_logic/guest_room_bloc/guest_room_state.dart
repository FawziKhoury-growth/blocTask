// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'guest_room_bloc.dart';

class GuestRoomState extends Equatable {
  final GuestRoomStatus guestRoomStatus;
  final int adultCounter;
  final int childrenCounter;
  final List<int> childrenAge;
  GuestRoomState({
    this.guestRoomStatus = GuestRoomStatus.none,
    this.adultCounter = 0,
    this.childrenCounter = 0,
    this.childrenAge = const [],
  });

  @override
  List<Object> get props =>
      [guestRoomStatus, adultCounter, childrenCounter, childrenAge];

  GuestRoomState copyWith({
    GuestRoomStatus? guestRoomStatus,
    int? adultCounter,
    int? childrenCounter,
    List<int>? childrenAge,
  }) {
    return GuestRoomState(
      guestRoomStatus: guestRoomStatus ?? this.guestRoomStatus,
      adultCounter: adultCounter ?? this.adultCounter,
      childrenCounter: childrenCounter ?? this.childrenCounter,
      childrenAge: childrenAge ?? this.childrenAge,
    );
  }
}
