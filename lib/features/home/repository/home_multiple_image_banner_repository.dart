import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/multiple_image_banner_model.dart';

class HomeMultipleImageBannerRepository {
  Future<Either<NetworkException, List<MultipleImageBannerModel>>>
      getMultipleBannerImage() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response =
          await dio.get("/rest/V1/homepage/sliders?filter=qmb-col-banners");
      final data = response.data;
      // final data = jsonDecode(fixture("image_slider_list.json"));
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
