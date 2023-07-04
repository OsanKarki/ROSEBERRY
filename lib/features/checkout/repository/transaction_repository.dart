import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/checkout/model/initiate_transaction_model.dart';
import 'package:ecommerce_app/features/checkout/model/transaction_params.dart';
import 'package:get/get.dart';
import '../../addressbook/repository/address_repository.dart';

class TransactionRepository {
  Future<Either<NetworkException, InitiateTransactionModel>> initializeTransaction(
      TransactionParams transactionParams) async {
    try {
      final data =await Get.find<ApiClient>().authTransactionPost(
          ApiConstants.initiateTransaction,
          data: transactionParams.toJson());
      final transaction = InitiateTransactionModel.fromJson(data["data"]);

      return right(transaction);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException('No internet connection'));
      } else if (e is DioError && e.type == DioErrorType.badResponse) {
        return left(NetworkException('${e.response?.data['error']}')) ;
      } else {
        return left(NetworkException(e.toString()));
      }
    }
  }
}
