class ProfileUpdateParams {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? companyBrn;

  ProfileUpdateParams(
      {this.firstName, this.lastName, this.phoneNumber, this.companyBrn});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['firstname'] = firstName;
    json['lastname'] = lastName;
    json['mobile'] = phoneNumber;
    json['companyBrn'] = companyBrn;

    return json;
  }
}
