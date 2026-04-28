import 'dart:convert';
import 'package:country_explorer_app/models/country.dart';
import 'package:http/http.dart' as http;

class Region {
  Future<List<Country>> fetchByRegion(String region) async {
    final url = Uri.parse('https://restcountries.com/v3.1/region/$region');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => Country.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
