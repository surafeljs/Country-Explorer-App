import 'dart:convert';
import 'package:country_explorer_app/models/country.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Country>> fetchCountry() async {
    final Uri url = Uri.parse(
      'https://restcountries.com/v3.1/all?fields=name,capital,currencies,region,subregion,flags',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
