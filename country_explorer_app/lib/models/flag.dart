class Flag {
  final String png;

  Flag({required this.png});

  factory Flag.fromJson(Map<String, dynamic> json) {
    return Flag(png: json['png'] ?? ' ');
  }

  Map<String, dynamic> toJson() {
    return {'png': png};
  }
}
