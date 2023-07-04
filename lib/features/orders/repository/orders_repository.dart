import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/addressbook/repository/address_repository.dart';
import 'package:ecommerce_app/features/orders/model/orders_info_model.dart';
import 'package:get/get.dart';

import '../../../core/data/remote/api_client.dart';
import '../../../core/data/remote/api_constants.dart';

class OrdersRepository{
  
  Future<Either<NetworkException,List<OrderInfoModel>>>getOrderInfo()async{
    try{
      final data = await Get.find<ApiClient>().authGet(ApiConstants.getPlacedOrdersInfo);

      final ordersInfoList =data.map<OrderInfoModel>((orderJson){
        return OrderInfoModel.fromJson(orderJson);
      }).toList();
      
      return right(ordersInfoList);
      
    }catch(e){
      if(e is DioError && e.error.runtimeType==SocketException){
        return left(NetworkException("No Internet Connection"));
      }else{
        return left(NetworkException("${e.toString()}"));
      }
      
    }
  }
}