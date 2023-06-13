class ProfileUpdateParams {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;


  ProfileUpdateParams(
      {this.firstName, this.lastName, this.phoneNumber, });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['firstname'] = firstName;
    json['lastname'] = lastName;
    json['phoneno'] = phoneNumber;


    return json;
  }
}
