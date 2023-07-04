import 'package:dartz/dartz.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../auth/repository/auth_repository.dart';
import '../../model/country_model.dart';
import '../../repository/country_list_fetching_repository.dart';

class CountryListingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCountryInfo();
  }

  Either<NetworkException, List<CountryModel>>? result;

  final countryList = <CountryModel>[];

  Future<void> getCountryInfo() async {
    result = await CountryListFetchingRepository().getCountryList();
    result?.fold(
      (l) {
        countryList.clear();
      },
      (r) {
        countryList.clear();

        countryList.addAll(r);
      },
    );
    update();
  }
}
