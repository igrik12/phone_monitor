import 'package:get/get.dart';
import 'package:phone_monitor/controllers/database_controller.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static const _apiKey = 'PyVDfkGBthsQNbsDGHqfEaaDEVcKaJiD';

  static const adsRemoval = 'Ads removal';
  static const adsRemovalAndSupport = 'Ads removal and support';

  static const allIds = [adsRemoval, adsRemovalAndSupport];

  static Future init({String id}) async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey, appUserId: id);
  }

  static Future<List<Offering>> fetchOffersByIds(List<String> ids) async {
    final offers = await fetchOffers();
    return offers.where((offer) => ids.contains(offer.identifier)).toList();
  }

  static Future<List<Offering>> fetchOffers({bool all = true}) async {
    try {
      final offerings = await Purchases.getOfferings();

      if (!all) {
        final current = offerings.current;
        return current == null ? [] : [current];
      }
      return offerings.all.values.toList();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      Get.find<DatabaseController>().setPremium(true);
      return true;
    } catch (e) {
      Get.find<DatabaseController>().setPremium(false);
      return false;
    }
  }
}
