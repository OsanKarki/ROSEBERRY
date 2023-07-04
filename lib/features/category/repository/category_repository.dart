import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/category/model/category_model.dart';
import 'package:get/get.dart';

class CategoryRepository {
  Future<Either<NetworkException, List<CategoryModel>>> getCategory() async {


    try {
      final data = await Get.find<ApiClient>().get(ApiConstants.getCategories);

      final categoryList = data['children_data'];

      final categoryModelList = categoryList
          .map<CategoryModel>((dataJson) => CategoryModel.fromJson(dataJson))
          .toList();

      return right(categoryModelList);
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
