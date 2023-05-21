import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/home/model/image_slider_model.dart';

class HomeRepository {
  Future<Either<NetworkException, List<ImageSliderModel>>>
      getImageSlider() async {
    final dio = Dio();
    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response =
          await dio.get("/rest/V1/homepage/sliders?filter=qmb-sliders");
      final data = response.data;
      // final data = jsonDecode(fixture("image_slider_list.json"));
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
