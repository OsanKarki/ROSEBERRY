import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/addressbook/model/country_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../auth/repository/auth_repository.dart';
import '../../auth/repository/auth_status_repository.dart';

class CountryListFetchingRepository {
  Future<Either<NetworkException, List<CountryModel>>> getCountryList() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(

    ));

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('/rest/V1/directory/countries');

      final data = response.data;

      print(response.data);

      final countryList = data;
      final countryModelList = countryList.map<CountryModel>((countryList) {
        return CountryModel.fromJson(countryList);
      }).toList();
      return right(countryModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }
  Future<Either<NetworkException, List<CountryProvinceModel>>> getProvinceList(String countryId) async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(

    ));

    dio.options.baseUrl = "https://qmbmart.store";

    try {
      final token = await AuthStatusRepository().getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('/rest/V1/regions/$countryId');

      final data = response.data;

      print(response.data);

      final provinceList = data;
      final provinceModelList = provinceList.map<CountryProvinceModel>((provinceList) {
        return CountryProvinceModel.fromJson(provinceList);
      }).toList();
      return right(provinceModelList);
    } catch (e) {
      if (e is DioError && e.error.runtimeType == SocketException) {
        return left(NetworkException("No Internet Connection"));
      } else {
        return left(NetworkException("${e.toString()}"));
      }
    }
  }
}
