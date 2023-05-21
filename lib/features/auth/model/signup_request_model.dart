class SignupRequestModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phoneNumber;

  SignupRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,

  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['firstname'] = firstName;
    json['lastname'] = lastName;
    json['email'] = email;
    json['password'] = password;
    json['phoneno'] = phoneNumber;


    return json;
  }
}
