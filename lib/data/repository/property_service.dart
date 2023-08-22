import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/property_model.dart';

class PropertyService {
  Future<List<PropertyModel>> getAllAvailableProperties() async {
    List<PropertyModel> _listProperty = [];
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.88.10:31535/otonomus/inventory/api/v1/spaces/available_spaces"));
      var decodedResponse = jsonDecode(response.body);
      // print(decodedResponse);

      var result = decodedResponse['data'] as List;

      _listProperty = result.map((map) => PropertyModel.fromJson(map)).toList();
    } catch (e) {
      print("error occur");
    }

    return _listProperty;
  }
}
