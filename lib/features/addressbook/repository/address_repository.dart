import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/addressbook/model/address_params_model.dart';
import 'package:ecommerce_app/features/addressbook/model/default_address_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../auth/repository/auth_status_repository.dart';
import '../model/address_model.dart';

class AddressRepository {
  Future<Either<NetworkException, String>> addNonDefaultAddress(
      AddressAddingParams addressAddingParams) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true));
    dio.options.baseUrl = "https://qmbmart.store";
    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post("/rest/V1/customer/address/add",
          data: addressAddingParams.toJson());
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

  Future<Either<NetworkException, List<AddressModel>>> getNonDefaultAddress() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    dio.options.baseUrl = "https://qmbmart.store";
    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get("/rest/V1/customer/ndaddress");
      final data = response.data;
      final categoryModelList = data
          .map<AddressModel>((dataJson) => AddressModel.fromJson(dataJson))
          .toList();
      print(categoryModelList);

      return right(categoryModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> deleteAddress(String id) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.delete(
        '/rest/V1/delete/address/$id',
      );

      final data = response.data;
      print(response.data);
      return right(data[0]["message"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, String>> setDefaultShippingAddress(String id) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.put(
        '/rest/V1/set/shippingAddress/$id',
      );

      final data = response.data;
      print(response.data);
      return right(data[0]["messgae"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }



  Future<Either<NetworkException, String>> setDefaultBillingAddress(String id) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.put(
        '/rest/V1/set/billingAddress/$id',
      );

      final data = response.data;
      print(response.data);
      return right(data[0]["messgae"]);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }

  Future<Either<NetworkException, DefaultAddressModel>> getDefaultAddresses() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get("/rest/V1/customer/address");

      final data = response.data;

      final addressModelList = DefaultAddressModel.fromJson(data[0]);

      return right(addressModelList);
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
