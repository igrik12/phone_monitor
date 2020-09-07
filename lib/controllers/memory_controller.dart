import 'package:get/get.dart';

class MemoryController extends GetxController {
  MemoryController();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
