import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/auth/repository/auth_repository.dart';
import 'package:ecommerce_app/features/cart/model/add_to_cart_params.dart';
import 'package:ecommerce_app/features/cart/model/get_to_cart_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../auth/repository/auth_status_repository.dart';

class CartRepository {
  Future<Either<NetworkException, String>> addToCart(
      AddToCartParams addToCartParams) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    dio.options.baseUrl = "https://qmbmart.store";
    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.post("/rest/V1/cart/add", data: addToCartParams.toJson());
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

  Future<Either<NetworkException, CartDetailsModel>> getCartItem() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('/rest/V1/cart');

      final data = response.data;
      print("@@@@@@@@@");
      print(response.data);
      if (data != null) {
        final cartList = data[0]["cart"];
        final cartModelList = CartDetailsModel.fromJson(cartList);
        return right(cartModelList);
      } else {
        // Return an empty CartDetailsModel instance or any other default value
        return right(CartDetailsModel());
      }
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
