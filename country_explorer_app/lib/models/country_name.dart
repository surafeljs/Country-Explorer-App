class CountryName {
  final String common;

  CountryName({required this.common});

  factory CountryName.fromJson(Map<String, dynamic> json) {
    return CountryName(common: json['common'] ?? ' ');
  }
}
