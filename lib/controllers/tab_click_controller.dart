import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TabClickController extends GetxController {
  RxInt _clicked = 0.obs;
  RxInt get clicked => _clicked;

  void resetClicks() {
    _clicked.value = 0;
  }

  void click() {
    _clicked.value++;
  }
}
