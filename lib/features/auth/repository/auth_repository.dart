import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/auth/model/signin_request_model.dart';
import 'package:ecommerce_app/features/auth/model/signup_request_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthRepository {
  Future<Either<NetworkException, String>> register(SignupRequestModel signupRequestModel) async {


    try {
      final response = await Get.find<ApiClient>().post(ApiConstants.register,
          data: signupRequestModel.toJson());
      final data = response.data;

      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> login(
      SignInRequestModel signInRequestModel) async {
    try {
      final data = await Get.find<ApiClient>()
          .post(ApiConstants.login, data: signInRequestModel.toJson());

      const FlutterSecureStorage()
          .write(key: "ACCESS_TOKEN", value: data[0]["token"]);

      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else if (e is DioError) {
        final error = e.response?.data[0]["message"];
        return left(NetworkException(error));
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
