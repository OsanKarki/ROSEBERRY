import 'package:ecommerce_app/features/addressbook/model/country_model.dart';

class AddressModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? telephoneNo;
  final String? province;
  final String? regionId;
  final String? city;
  final CountryModel? country;
  final String? street;
  final String? company;
  final String? postalCode;

  AddressModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.telephoneNo,
      this.country,
      this.province,
      this.street,
      this.city,
      this.postalCode,
      this.company,
      this.regionId});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["entity_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      company: json["company"],
      street: json["street"],
      city: json["city"],
      province: json["province"],
      regionId: json["region_id"].toString(),
      postalCode: json["postal_code"],
      telephoneNo: json["telephone"],
      country: CountryModel.fromJsonAlternative( json["country"]),
    );
  }
}



