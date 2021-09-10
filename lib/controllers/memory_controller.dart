import 'package:get/get.dart';

class MemoryController extends GetxController {
  MemoryController();

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
