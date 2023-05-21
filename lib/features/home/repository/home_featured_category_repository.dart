import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/image_featured_category_model.dart';

class HomeFeaturedCategoryRepository {
  Future<Either<NetworkException, List<ImageFeaturedCategoryModel>>>
      getBannerImage() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response =
          await dio.get("/rest/V1/homepage/sliders?filter=qmb-slider-banners");
      final data = response.data;
      // final data = jsonDecode(fixture("image_slider_list.json"));
      final imageList = data[0]['image'];

      final imageFeaturedCategoryModelList = imageList.map<ImageFeaturedCategoryModel>((imageJson) {
        return ImageFeaturedCategoryModel.fromJson(imageJson);
      }).toList();

      // final imageSliderModelList = <ImageSliderModel>[];
      // final imageList = data[0]['image'];
      //
      // for(int i = 0;i<imageList.length;i++){
      //   final imageJson = imageList[i];
      //
      //   final imageSliderModel = ImageSliderModel.fromJson(imageJson);
      //
      //   imageSliderModelList.add(imageSliderModel);
      //
      //
      //start
      // }

      return right(imageFeaturedCategoryModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }
}

class NetworkException {
  String value;

  NetworkException(this.value);
}
