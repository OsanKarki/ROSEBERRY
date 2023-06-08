import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/model/signin_request_model.dart';
import 'package:ecommerce_app/features/auth/model/signup_request_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthRepository {
  Future<Either<NetworkException, String>> register(SignupRequestModel signupRequestModel) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true));
    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.post("/rest/V1/customer/register",
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
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true));
    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.post("/rest/V1/customer/login",
          data: signInRequestModel.toJson());
      final data = response.data;
      const FlutterSecureStorage().write(key: "ACCESS_TOKEN", value: data[0]["token"]);

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
