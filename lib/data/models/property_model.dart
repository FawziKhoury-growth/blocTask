// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  final String propertyId;
  final String propertyName;
  final List<AvailableSpace> availableSpaces;

  const PropertyModel({
    required this.propertyId,
    required this.propertyName,
    required this.availableSpaces,
  });

  static const empty = PropertyModel(
    propertyId: "",
    propertyName: "",
    availableSpaces: [],
  );

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        propertyId: json["propertyId"],
        propertyName: json["propertyName"],
        availableSpaces: List<AvailableSpace>.from(
            json["availableSpaces"].map((x) => AvailableSpace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "propertyId": propertyId,
        "propertyName": propertyName,
        "availableSpaces":
            List<dynamic>.from(availableSpaces.map((x) => x.toJson())),
      };

  PropertyModel copyWith({
    String? propertyId,
    String? propertyName,
    List<AvailableSpace>? availableSpaces,
  }) {
    return PropertyModel(
      propertyId: propertyId ?? this.propertyId,
      propertyName: propertyName ?? this.propertyName,
      availableSpaces: availableSpaces ?? this.availableSpaces,
    );
  }
}

class AvailableSpace {
  final String spaceId;
  final String propertyName;
  final String spaceTitle;
  final String spaceDescription;
  final double spaceRating;
  final int spacePrice;
  final List<String> spaceImages;
  final int currentIndex;

  const AvailableSpace(
      {required this.spaceId,
      required this.propertyName,
      required this.spaceTitle,
      required this.spaceDescription,
      required this.spaceRating,
      required this.spacePrice,
      required this.spaceImages,
      this.currentIndex = 0});

  factory AvailableSpace.fromJson(Map<String, dynamic> json) => AvailableSpace(
        spaceId: json["spaceId"],
        propertyName: json["propertyName"],
        spaceTitle: json["spaceTitle"],
        spaceDescription: json["spaceDescription"],
        spaceRating: json["spaceRating"],
        spacePrice: json["spacePrice"],
        spaceImages: List<String>.from(json["spaceImages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "spaceId": spaceId,
        "propertyName": propertyName,
        "spaceTitle": spaceTitle,
        "spaceDescription": spaceDescription,
        "spaceRating": spaceRating,
        "spacePrice": spacePrice,
        "spaceImages": List<dynamic>.from(spaceImages.map((x) => x)),
      };

  AvailableSpace copyWith({
    String? spaceId,
    String? propertyName,
    String? spaceTitle,
    String? spaceDescription,
    double? spaceRating,
    int? spacePrice,
    List<String>? spaceImages,
    int? currentIndex,
  }) {
    return AvailableSpace(
      propertyName: propertyName ?? this.propertyName,
      spaceDescription: spaceDescription ?? this.spaceDescription,
      spaceId: spaceId ?? this.spaceId,
      spaceImages: spaceImages ?? this.spaceImages,
      spacePrice: spacePrice ?? this.spacePrice,
      spaceRating: spaceRating ?? this.spaceRating,
      spaceTitle: spaceTitle ?? this.spaceTitle,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
