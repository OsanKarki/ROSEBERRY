import 'package:dartz/dartz.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../auth/repository/auth_repository.dart';
import '../../model/country_model.dart';
import '../../repository/country_list_fetching_repository.dart';

class ProvinceListingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Either<NetworkException, List<CountryProvinceModel>>? result;

  final provinceList = <CountryProvinceModel>[];

  Future<void> getProvinceInfo(String countryId) async {
    result = await CountryListFetchingRepository().getProvinceList(countryId);
    result?.fold((l) {
      print("NO@@@@@@data");

      provinceList.clear();
    }, (r) {
      provinceList.clear();
      print("@@@@@@data");
      provinceList.addAll(r);
    });
    update();
  }

}
