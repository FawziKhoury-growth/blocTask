// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'property_bloc.dart';

class PropertyState extends Equatable {
  final List<PropertyModel> listProperty;
  final PropertyModel selectedProperty;
  final PropertyStatus propertyStatus;

  PropertyState(
      {this.listProperty = const [],
      this.selectedProperty = PropertyModel.empty,
      this.propertyStatus = PropertyStatus.none});

  @override
  List<Object> get props => [listProperty, selectedProperty, propertyStatus];

  PropertyState copyWith({
    List<PropertyModel>? listProperty,
    PropertyModel? selectedProperty,
    PropertyStatus? propertyStatus,
  }) {
    return PropertyState(
      listProperty: listProperty ?? this.listProperty,
      selectedProperty: selectedProperty ?? this.selectedProperty,
      propertyStatus: propertyStatus ?? this.propertyStatus,
    );
  }
}
