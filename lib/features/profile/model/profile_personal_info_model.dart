class ProfilePersonalInfoModel {
  final String? firstName;
  final String? lastname;
  final String? email;
  final String? phoneNo;

  ProfilePersonalInfoModel(
      {this.firstName, this.lastname, this.email, this.phoneNo});

  factory ProfilePersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return ProfilePersonalInfoModel(
      firstName: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phoneNo: json['phoneno'],
    );
  }
}
