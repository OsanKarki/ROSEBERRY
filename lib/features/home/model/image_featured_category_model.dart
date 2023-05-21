class ImageFeaturedCategoryModel{
  final String? image;

  ImageFeaturedCategoryModel({this.image});
  factory ImageFeaturedCategoryModel.fromJson(Map<String,dynamic>json){
    return ImageFeaturedCategoryModel(image: json['image']);
  }
}