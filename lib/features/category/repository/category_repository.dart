import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/category/model/category_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CategoryRepository {
  Future<Either<NetworkException, List<CategoryModel>>> getCategory() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.get("/rest/V1/categories");
      final data = response.data;
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
