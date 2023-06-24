import 'dart:convert';

import 'package:covid_tracker_project/Services/Utilities/api_url.dart';
import 'package:http/http.dart' as http;

import '../Models/World_state_model.dart';

class StateServices {
  Future<WorldStateModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(ApiUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }


  Future<List<dynamic>> countryListApi() async {
    var data;
    final response = await http.get(Uri.parse(ApiUrl.countriesList));

    if (response.statusCode == 200) {
       data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
