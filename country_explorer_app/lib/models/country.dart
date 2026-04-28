import 'package:country_explorer_app/models/country_name.dart';
import 'package:country_explorer_app/models/flag.dart';

class Country {
  final CountryName name;
  final String region;
  final String subregion;
  final Flag flags;
  final List<String> capital;

  Country({
    required this.name,
    required this.region,
    required this.subregion,
    required this.flags,

    required this.capital,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: CountryName.fromJson(json['name']),
      region: json['region'] as String? ?? 'empty',
      subregion: json['subregion'] as String? ?? 'empty',
      flags: Flag.fromJson(json['flags'] ?? {}),

      capital: List<String>.from(json['capital']),
    );
  }
}
