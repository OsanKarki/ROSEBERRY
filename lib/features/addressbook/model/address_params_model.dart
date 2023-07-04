import 'dart:convert';

class AddressAddingParams {
  final String? firstName;
  final String? lastName;
  final String? telephoneNo;
  final String? province;
  final String? provinceId;
  final String? city;
  final String? country;
  final String? street;
  final String? company;
  final String? postalCode;

  AddressAddingParams(
      {this.firstName,
      this.lastName,
      this.city,
      this.company,
      this.country,
      this.postalCode,
      this.province,
      this.street,
        this.provinceId,
      this.telephoneNo});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json["first_name"] = firstName;
    json["last_name"] = lastName;
    json["country_code"] = country;
    json["postal_code"] = postalCode;
    json["city"] = city;
    json["telephone"] = telephoneNo;
    json["company"] = company;
    json["street"] = street;
    json["province"] = province;
    json["province_id"] = provinceId;

    return json;
  }
}


