import 'dart:convert';
import 'package:country_explorer_app/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  Future<List<Country>> fetchCountry() async {
    // Check connectivity before making API call
    final connectivityResult = await Connectivity().checkConnectivity();

    // If no internet connection, throw a specific exception
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception(
        'No internet connection. Please check your network and try again.',
      );
    }

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
      throw Exception(
        'Failed to load countries. Status code: ${response.statusCode}',
      );
    }
  }
}
