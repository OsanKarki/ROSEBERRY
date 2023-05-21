class SignInRequestModel{
  final String? email;
  final String? password;

  SignInRequestModel({this.email,this.password});

  Map<String,dynamic> toJson(){
    final json = <String,dynamic>{};
    json['email'] = email;
    json['password'] = password;

    return json;
  }


}