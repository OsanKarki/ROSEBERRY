class SingleImageBannerModel{
  final String? image;

  SingleImageBannerModel({this.image});
  factory SingleImageBannerModel.fromJson(Map<String,dynamic>json){
    return SingleImageBannerModel(image: json['image']);
  }
}