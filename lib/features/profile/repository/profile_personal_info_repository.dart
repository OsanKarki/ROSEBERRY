import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/repository/auth_status_repository.dart';
import 'package:ecommerce_app/features/home/model/image_slider_model.dart';
import 'package:ecommerce_app/features/profile/model/profile_personal_info_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ProfileRepository {
  Future<Either<NetworkException, ProfilePersonalInfoModel>>
  getUserInfo() async {
    final dio = Dio();

    dio.interceptors.add(PrettyDioLogger());
    dio.options.baseUrl = "https://qmbmart.store";

    try {

      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
      await dio.get("/rest/V1/customer/me", );
      final data = response.data;
      // final data = jsonDecode(fixture("image_slider_list.json"));
      final infoJson = data[0];

      final personalInfoModelList =  ProfilePersonalInfoModel.fromJson(infoJson);

      return right(personalInfoModelList);
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
