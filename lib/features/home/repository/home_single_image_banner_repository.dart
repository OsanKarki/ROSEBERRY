import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/single_image_banner_model.dart';

class HomeSingleImageBannerRepository {
  Future<Either<NetworkException, SingleImageBannerModel>>
      getSingleBannerImage() async {


    try {
      final data =
          await Get.find<ApiClient>().get(ApiConstants.getSingleBannerImage);

      // final data = jsonDecode(fixture("image_slider_list.json"));
      final imageJson = data[0];

      final singleImageBannerModelList =
          SingleImageBannerModel.fromJson(imageJson);

      return right(singleImageBannerModelList);
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
