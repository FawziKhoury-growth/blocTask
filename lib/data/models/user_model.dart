import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String idUser;
  final String firstName;
  final String lastName;
  final String email;

  const UserModel({
    required this.idUser,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  static const empty = UserModel(
    idUser: "",
    firstName: "",
    lastName: "",
    email: "",
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idUser,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
