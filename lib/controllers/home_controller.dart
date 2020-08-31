import 'package:get/get.dart';

class HomeController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int value) {
    _currentIndex = value;
    update();
  }
}
