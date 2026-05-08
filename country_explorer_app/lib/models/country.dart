import 'package:country_explorer_app/models/country_name.dart';
import 'package:country_explorer_app/models/flag.dart';

class Country {
  final CountryName name;
  final String region;
  final String subregion;
  final Flag flags;
  final List<String> capital;
  final Map<String, dynamic> currencies;

  Country({
    required this.name,
    required this.region,
    required this.subregion,
    required this.flags,
    required this.capital,
    required this.currencies,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: CountryName.fromJson(json['name']),
      region: json['region'] as String? ?? 'empty',
      subregion: json['subregion'] as String? ?? 'empty',
      flags: Flag.fromJson(json['flags'] ?? {}),
      capital: List<String>.from(json['capital'] ?? []),
      currencies: json['currencies'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      'region': region,
      'subregion': subregion,
      'flags': flags.toJson(),
      'capital': capital,
      'currencies': currencies,
    };
  }
}
