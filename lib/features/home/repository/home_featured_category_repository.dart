import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:get/get.dart';

import '../model/image_featured_category_model.dart';

class HomeFeaturedCategoryRepository {
  Future<Either<NetworkException, List<ImageFeaturedCategoryModel>>>
      getBannerImage() async {

    try {
      final data =
          await Get.find<ApiClient>().get(ApiConstants.featuredCategory);

      // final data = jsonDecode(fixture("image_slider_list.json"));
      final imageList = data[0]['image'];

      final imageFeaturedCategoryModelList = imageList.map<ImageFeaturedCategoryModel>((imageJson) {
        return ImageFeaturedCategoryModel.fromJson(imageJson);
      }).toList();


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
