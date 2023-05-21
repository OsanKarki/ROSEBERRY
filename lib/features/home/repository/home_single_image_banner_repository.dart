import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/multiple_image_banner_model.dart';
import '../model/single_image_banner_model.dart';

class HomeSingleImageBannerRepository {
  Future<Either<NetworkException, SingleImageBannerModel>>
      getSingleBannerImage() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response =
          await dio.get("/rest/V1/homepage/sliders?filter=qmb-single-banner");
      final data = response.data;
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
