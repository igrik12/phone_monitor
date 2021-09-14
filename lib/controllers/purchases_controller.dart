import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesController extends GetxController {
  final RxBool paid = false.obs;
  @override
  void onInit() {
    super.onInit();
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      final purchasesInfo = await Purchases.getPurchaserInfo();
      final entitlements = purchasesInfo.entitlements.active.values.toList();
      paid(entitlements.isEmpty ? false : true);
    });
  }
}
