class ImageSliderModel{
  final String? image;

  ImageSliderModel({this.image});
  factory ImageSliderModel.fromJson(Map<String,dynamic>json){
    return ImageSliderModel(image: json['image']);
  }
}