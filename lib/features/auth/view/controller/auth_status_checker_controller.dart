import 'package:ecommerce_app/features/auth/repository/auth_status_repository.dart';
import 'package:get/get.dart';

class AuthStatusController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkIfAuthenticated();
  }

  RxBool isAuthenticated = false.obs;

  checkIfAuthenticated() async {
    isAuthenticated.value = await AuthStatusRepository().isAuthenticated();
  }

  updateAuthenticationStatus(bool status) {
    isAuthenticated.value = status;
  }

  logout() async {
    await AuthStatusRepository().logout();
    updateAuthenticationStatus(false);
  }
}
