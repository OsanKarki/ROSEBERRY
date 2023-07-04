import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/auth/repository/auth_status_repository.dart';
import 'package:ecommerce_app/features/profile/model/profile_personal_info_model.dart';
import 'package:ecommerce_app/features/profile/update_profile/model/update_profile_model.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/data/remote/api_client.dart';

class ProfileRepository {
  Future<Either<NetworkException, ProfilePersonalInfoModel>>
      getUserInfo() async {
    try {
      final data = await Get.find<ApiClient>().authGet(
        ApiConstants.getUserInfo,
      );

      final infoJson = data[0];

      final personalInfoModelList = ProfilePersonalInfoModel.fromJson(infoJson);

      return right(personalInfoModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> update(
      ProfileUpdateParams profileUpdateParams) async {


    try {

      final data = await Get.find<ApiClient>().authPut(ApiConstants.updateUserInfo,
          data: profileUpdateParams.toJson());

      return right(data[0]["message"]);
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
