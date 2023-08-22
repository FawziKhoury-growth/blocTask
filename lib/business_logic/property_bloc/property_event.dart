// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'property_bloc.dart';

sealed class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object> get props => [];
}

class OnFetchProperty extends PropertyEvent {
  const OnFetchProperty();
  @override
  List<Object> get props => [];
}

class OnSetSelectedProperty extends PropertyEvent {
  final PropertyModel selectedProperty;
  const OnSetSelectedProperty(this.selectedProperty);
  @override
  List<Object> get props => [selectedProperty];
}

class OnSetIndexSpace extends PropertyEvent {
  final AvailableSpace availableSpace;
  final int index;
  OnSetIndexSpace({
    required this.availableSpace,
    required this.index,
  });
  @override
  List<Object> get props => [availableSpace, index];
}
