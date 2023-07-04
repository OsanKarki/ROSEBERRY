import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/data/remote/api_client.dart';
import 'package:ecommerce_app/core/data/remote/api_constants.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:ecommerce_app/features/product/model/product_model.dart';
import 'package:get/get.dart';

class ProductRepository {
  Future<Either<NetworkException, List<ProductModel>>>
      getTopRatedProduct(FilterQueryParams filterQueryParams) async {
    try {
      final data =
          await Get.find<ApiClient>().get(ApiConstants.products,queryParams: filterQueryParams.toJson());

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
      getBestSellerProduct(FilterQueryParams filterQueryParams) async {
    try {
      final data =
          await Get.find<ApiClient>().get(ApiConstants.products,queryParams: filterQueryParams.toJson());


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
      getTopDealsProduct(FilterQueryParams filterQueryParams) async {
    try {
      final data =
          await Get.find<ApiClient>().get(ApiConstants.products,queryParams: FilterQueryParams().toJson());

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
      String sku) async {


    try {
      final data = await  Get.find<ApiClient>().get("${ApiConstants.getProductDetails}?sku=$sku");


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


    try {
      final data = await  Get.find<ApiClient>().get(ApiConstants.products,
          queryParams: filterQueryParams.toJson());


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
