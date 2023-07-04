import 'package:get/get.dart';

import '../data/remote/api_client.dart';

class CoreBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiClient());


  }

}