import 'dart:convert';
import 'package:country_explorer_app/models/country.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future<List<Country>> searchCountries(String query) async {
    final Uri url = Uri.parse(
      'https://restcountries.com/v3.1/all?fields=name,capital,currencies,region,subregion,flags',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final countries = data
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();

      if (query.isEmpty) {
        return countries
            .take(10)
            .toList(); // Return first 10 countries if no search
      }

      // Filter countries based on search query
      return countries.where((country) {
        final name = country.name.common.toLowerCase();
        final capital = country.capital.isNotEmpty
            ? country.capital[0].toLowerCase()
            : '';
        final region = country.region.toLowerCase();
        final subregion = country.subregion.toLowerCase();

        final searchLower = query.toLowerCase();

        return name.contains(searchLower) ||
            capital.contains(searchLower) ||
            region.contains(searchLower) ||
            subregion.contains(searchLower);
      }).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
