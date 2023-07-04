import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/addressbook/repository/address_repository.dart';
import 'package:ecommerce_app/features/checkout/model/order_Summary_model.dart';
import 'package:ecommerce_app/features/checkout/model/order_response.dart';
import 'package:ecommerce_app/features/checkout/model/payment_model.dart';
import 'package:ecommerce_app/features/checkout/model/transaction_params.dart';
import 'package:get/get.dart';

import '../model/shipping_info_params.dart';

class CheckoutRepository {
  Future<Either<NetworkException, PaymentModel>> getPaymentMethod() async {
    try {
      final data =
          await Get.find<ApiClient>().authGet(ApiConstants.getPaymentMethod);
      final paymentList = data[0];
      final paymentModelList = PaymentModel.fromJson(paymentList);
      return right(paymentModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> setShippingInfo(
      ShippingParams shippingParams) async {
    try {
      final data = await Get.find<ApiClient>().authPost(
          ApiConstants.setShippingInfo,
          data: shippingParams.toJson());
      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> setPaymentMethod(
      String payment) async {
    try {
      final data = await Get.find<ApiClient>()
          .authPost(ApiConstants.setPaymentMethod, data: {"payment": payment});
      print("here 1");
      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, OrderSummaryModel>> getOrderSummary() async {
    try {
      final data =
          await Get.find<ApiClient>().authGet(ApiConstants.getOrderSummary);

      final orderSummary = OrderSummaryModel.fromJson(data[0]);

      return right(orderSummary);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, OrderData>> placeOrder() async {
    try {
      final data =
          await Get.find<ApiClient>().authPost(ApiConstants.placeOrder);
      final placingOrder = OrderData.fromJson(data[0]["data"]);
      return right(placingOrder);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Exception"));
      } else if (e is DioError && e.type == DioErrorType.badResponse) {
        return left(NetworkException('${e.response?.data['message']}'));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }
}
