import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/cart/model/add_to_cart_params.dart';
import 'package:ecommerce_app/features/cart/model/get_to_cart_model.dart';
import 'package:ecommerce_app/features/cart/model/update_cart_model.dart';
import 'package:get/get.dart';


class CartRepository {
  Future<Either<NetworkException, String>> addToCart(
      AddToCartParams addToCartParams) async {
    try {
      final data = await Get.find<ApiClient>()
          .authPost(ApiConstants.addToCart, data: addToCartParams.toJson());

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
    try {
      final data =
          await Get.find<ApiClient>().authGet(ApiConstants.getCartItem);

      if (data != null) {
        final cartList = data[0]["cart"];
        final cartModelList = CartDetailsModel.fromJson(cartList);
        return right(cartModelList);
      } else {
        // Return an empty CartDetailsModel instance or any @other default value
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

  Future<Either<NetworkException, String>> delCartItem(int id) async {
    try {
      final data = await Get.find<ApiClient>().authDelete(
        "${ApiConstants.deleteCartItem}/$id",
      );

      print(data);
      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> delAllCartItem() async {
    try {
      final data = await Get.find<ApiClient>().authDelete(
        ApiConstants.deleteAllCartItem,
      );

      print(data);
      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> updateCartItem(
      UpdateCartItemParams updateCartItemParams) async {
    try {
      final data = await Get.find<ApiClient>().authPut(
          ApiConstants.updateCartItem,
          data: updateCartItemParams.toJson());

      print(data);
      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else if (e is DioError && e.type == DioErrorType.badResponse) {
        return left(NetworkException("${e.response?.data[0]["error"]}"));
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
