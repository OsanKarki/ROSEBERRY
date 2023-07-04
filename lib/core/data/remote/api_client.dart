import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../features/auth/repository/auth_status_repository.dart';
import '../../../features/auth/view/controller/auth_status_checker_controller.dart';

class ApiClient {
  final Dio dio;
  final Dio dioPayStack;

  ApiClient()
      : dio = Dio(),
        dioPayStack = Dio() {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      requestBody: true,
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          AuthStatusController().logout();
        }
        handler.next(error);
      },
      onRequest: (requestOptions, handler) async {
        if (requestOptions.headers["requiresToken"] == true) {
          final token = await AuthStatusRepository().getAccessToken();
          requestOptions.headers["Authorization"] = 'Bearer $token';
        }
        handler.next(requestOptions);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 401 &&
            response.data['message'] == 'Token expired !!') {
          AuthStatusController().logout();
        }
        handler.next(response);
      },
    ));
    dio.options.baseUrl = "https://qmbmart.store";
    dioPayStack.options.baseUrl= "https://api.paystack.co";

    dioPayStack.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      requestBody: true,
    ));
    dioPayStack.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {

        handler.next(error);
      },
      onRequest: (requestOptions, handler) async {
        if (requestOptions.headers["requiresToken"] == true) {
          final token = "sk_test_6f1eb6418ddacc8193ea2abaa5d5f1481876c6a1";
          requestOptions.headers["Authorization"] = 'Bearer $token';
        }
        handler.next(requestOptions);
      },
      onResponse: (response, handler) {

        handler.next(response);
      },
    ));
    // Additional interceptors or configurations for Paystack API can be added here
  }

  get(String path, {Map<String, dynamic>? queryParams}) async {//
    final result = await dio.get(path, queryParameters: queryParams);
    return result.data;
  }

  authGet(String path) async {
    final result = await dio.get(path,
        options: Options(headers: {
          "requiresToken": true,
        }));
    return result.data;
  }

  post(String path, {Map<String, dynamic>? data}) async {
    final result = await dio.post(path, data: data);
    return result.data;
  }

  authPost(String path, {Map<String, dynamic>? data}) async {
    final result = await dio.post(path,
        data: data,
        options: Options(headers: {
          "requiresToken": true,
        }));
    return result.data;
  }

  authDelete(String path, {Map<String, dynamic>? data}) async {
    final result = await dio.delete(path,
        data: data,
        options: Options(headers: {
          "requiresToken": true,
        }));
    return result.data;
  }

  authPut(String path, {Map<String, dynamic>? data}) async {
    final result = await dio.put(path,
        data: data,
        options: Options(headers: {
          "requiresToken": true,
        }));
    return result.data;
  }


  ///////////////  * for auth post for transaction part * ////////////////////
  authTransactionPost(String path, {Map<String, dynamic>? data}) async {
    final result = await dioPayStack.post(path,
        data: data,
        options: Options(headers: {
          "requiresToken": true,
        }));
    return result.data;
  }


}
