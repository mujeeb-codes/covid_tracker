import 'dart:convert';

import 'package:covid_tracker/urls_api.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/api_Model.dart';

class GetApi {
  Future<ApiModel> getapi() async {
    final response = await http.get(Uri.parse(UrlsApi.worldstate));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return ApiModel.fromJson(data);
    } else {
      throw Exception("Error while fetching api");
    }
  }
}

class Countryapi {
  Future<List<dynamic>> countryapi() async {
    final response = await http.get(Uri.parse(UrlsApi.country));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error while fetching api");
    }
  }
}
