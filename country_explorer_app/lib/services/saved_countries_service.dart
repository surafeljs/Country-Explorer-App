import 'dart:convert';
import 'package:country_explorer_app/models/country.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedCountriesService {
  static const String _savedCountriesKey = 'saved_countries';

  Future<void> saveCountry(Country country) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCountries = await getSavedCountries();
    if (!savedCountries.any((c) => c.name.common == country.name.common)) {
      savedCountries.add(country);
      final countriesJson = savedCountries
          .map((c) => jsonEncode(c.toJson()))
          .toList();
      await prefs.setStringList(_savedCountriesKey, countriesJson);
    }
  }

  Future<void> removeCountry(Country country) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCountries = await getSavedCountries();
    savedCountries.removeWhere((c) => c.name.common == country.name.common);
    final countriesJson = savedCountries
        .map((c) => jsonEncode(c.toJson()))
        .toList();
    await prefs.setStringList(_savedCountriesKey, countriesJson);
  }

  Future<List<Country>> getSavedCountries() async {
    final prefs = await SharedPreferences.getInstance();
    final countriesJson = prefs.getStringList(_savedCountriesKey) ?? [];
    return countriesJson
        .map((json) => Country.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<bool> isCountrySaved(Country country) async {
    final savedCountries = await getSavedCountries();
    return savedCountries.any((c) => c.name.common == country.name.common);
  }
}
