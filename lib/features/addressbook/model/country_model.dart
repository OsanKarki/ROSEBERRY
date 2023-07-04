class CountryModel {
  final String? code;
  final String? fullName;

  CountryModel({this.code, this.fullName});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(code: json["two_letter_abbreviation"], fullName: json["full_name_english"]);
  }

  factory CountryModel.fromJsonAlternative(Map<String, dynamic> json) {
    return CountryModel(code: json["code"], fullName: json["name"]);
  }

}

class CountryProvinceModel {
  final String name;
  final String code;

  CountryProvinceModel({required this.name, required this.code});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryProvinceModel &&
        other.name == name &&
        other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;

  factory CountryProvinceModel.fromJson(Map<String, dynamic> json) {
    return CountryProvinceModel(code: json["code"], name: json["name"]);
  }
}
