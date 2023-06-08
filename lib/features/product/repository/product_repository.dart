import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:ecommerce_app/features/product/model/product_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ProductRepository {
  Future<Either<NetworkException, List<ProductModel>>> getTopRatedProduct() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.get(
          "/rest/V1/custom/products?topRated=true&searchCriteria[pageSize]=10&searchCriteria[currentPage]=1");

      // final data = jsonDecode(fixture("image_slider_list.json"));

      final data = response.data;
      // final data = jsonDecode(fixture("image_slider_list.json"));
      final productList = data[0]['items'];

      final productModelList = productList.map<ProductModel>((productJson) {
        return ProductModel.fromJson(productJson);
      }).toList();

      return right(productModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, List<ProductModel>>>
      getBestSellerProduct() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.get(
          "/rest/V1/custom/products?bestSeller=true&searchCriteria[pageSize]=10&searchCriteria[currentPage]=1");

      // final data = jsonDecode(fixture("image_slider_list.json"));

      final data = response.data;
      // final data = jsonDecode(fixture("image_slider_list.json"));
      final productList = data[0]['items'];

      final productModelList = productList.map<ProductModel>((productJson) {
        return ProductModel.fromJson(productJson);
      }).toList();

      return right(productModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, List<ProductModel>>>
      getTopDealsProduct() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.get(
          "/rest/V1/custom/products?searchCriteria[pageSize]=10&topDeals=true&searchCriteria[currentPage]=1");

      // final data = jsonDecode(fixture("image_slider_list.json"));

      final data = response.data;
      // final data = jsonDecode(fixture("image_slider_list.json"));
      final productList = data[0]['items'];

      final productModelList = productList.map<ProductModel>((productJson) {
        return ProductModel.fromJson(productJson);
      }).toList();

      return right(productModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, ProductModel>> getProductDetails(
      {required FilterQueryParams filterQueryParams}) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.get("/rest/V1/product",queryParameters: filterQueryParams.toJson());

      final data = response.data;

      final productJson = data[0];
      final productModel = ProductModel.fromJson(productJson);

      return right(productModel);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, List<ProductModel>>> getProductList(
      {required FilterQueryParams filterQueryParams}) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final response = await dio.get("/rest/V1/custom/products",
          queryParameters: filterQueryParams.toJson());

      final data = response.data;

      final productList = data[0]['items'];

      final productModelList = productList.map<ProductModel>((productJson) {
        return ProductModel.fromJson(productJson);
      }).toList();

      return right(productModelList);
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
