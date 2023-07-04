import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:get/get.dart';

import '../model/multiple_image_banner_model.dart';

class HomeMultipleImageBannerRepository {
  Future<Either<NetworkException, List<MultipleImageBannerModel>>>
      getMultipleBannerImage() async {


    try {
      final data =
          await Get.find<ApiClient>().get(ApiConstants.multipleImageBanner);

      final imageList = data[0]['image'];

      final imageBannerModelList =
          imageList.map<MultipleImageBannerModel>((imageJson) {
        return MultipleImageBannerModel.fromJson(imageJson);
      }).toList();

      return right(imageBannerModelList);
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
