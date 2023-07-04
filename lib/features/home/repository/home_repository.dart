import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/home/model/image_slider_model.dart';
import 'package:get/get.dart';

class HomeRepository {
  Future<Either<NetworkException, List<ImageSliderModel>>>
      getImageSlider() async {
    try {
      final data = await Get.find<ApiClient>().get(ApiConstants.getImageSlider);

      final imageList = data[0]['image'];

      final imageSliderModelList = imageList.map<ImageSliderModel>((imageJson) {
        return ImageSliderModel.fromJson(imageJson);
      }).toList();

      return right(imageSliderModelList);
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
