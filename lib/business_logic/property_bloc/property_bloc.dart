import 'package:bloc/bloc.dart';
import 'package:bloctask/data/enums/property_enum.dart';
import 'package:bloctask/data/repository/property_service.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/property_model.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyState()) {
    on<OnFetchProperty>(_fetchProperty);
    on<OnSetSelectedProperty>(_setSelectedProperty);
    on<OnSetIndexSpace>(_setIndexSpace);
  }

  void _fetchProperty(
      OnFetchProperty event, Emitter<PropertyState> emit) async {
    PropertyService propertyService = PropertyService();
    try {
      List<PropertyModel> listProperty =
          await propertyService.getAllAvailableProperties();
      emit(state.copyWith(
          listProperty: listProperty,
          selectedProperty: listProperty[0],
          propertyStatus: PropertyStatus.available));
    } catch (e) {
      emit(state.copyWith(propertyStatus: PropertyStatus.error));
    }
  }

  void _setSelectedProperty(
      OnSetSelectedProperty event, Emitter<PropertyState> emit) {
    emit(state.copyWith(selectedProperty: event.selectedProperty));
  }

  void _setIndexSpace(
      OnSetIndexSpace event, Emitter<PropertyState> emit) async {
    List<AvailableSpace> newAvailableSpaces = state
        .selectedProperty.availableSpaces
        .map((availableSpace) => availableSpace == event.availableSpace
            ? availableSpace.copyWith(currentIndex: event.index)
            : availableSpace)
        .toList();

    PropertyModel newSelectedProperty =
        state.selectedProperty.copyWith(availableSpaces: newAvailableSpaces);

    List<PropertyModel> newListProperty = state.listProperty
        .map(
          (e) => e == state.selectedProperty ? newSelectedProperty : e,
        )
        .toList();
    emit(state.copyWith(
      selectedProperty: newSelectedProperty,
      listProperty: newListProperty,
    ));
  }
}
