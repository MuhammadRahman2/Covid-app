import 'dart:convert';

import 'package:covid_19_apps/model/covid_model.dart';
import 'package:covid_19_apps/Screen/word_state.dart';
import 'package:http/http.dart' as http;

class AppUrl {
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';
  static const String countriesList = '${baseUrl}countries';
  static const String WorldStateApi = '${baseUrl}all';

  // static List<CovidModel> listCovid = [];
  Future<CovidModel> getAllCovidModel() async {
    final responce = await http.get(Uri.parse(WorldStateApi));
    final data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      // for (Map i in data) {
      // listCovid.add(CovidModel.fromJson(i));
      // }
      return CovidModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
// with out model  
  Future<List<dynamic>> getContriesCovidModel() async {
    final responce = await http.get(Uri.parse(countriesList));
    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body.toString());
      return data;
    } else{
      throw Exception('Countries Error');
    }
  }
}
