import 'package:get/get.dart';

class BnbController extends GetxController {
  int _index = 0;

  set index(int i) {
    _index = i;
    update();
  }

  int get index => _index;
}
