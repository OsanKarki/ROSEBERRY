class MultipleImageBannerModel{
  final String? image;

  MultipleImageBannerModel({this.image});
  factory MultipleImageBannerModel.fromJson(Map<String,dynamic>json){
    return MultipleImageBannerModel(image: json['image']);
  }
}