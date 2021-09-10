import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:phone_monitor/api/database_api.dart';
import 'package:phone_monitor/controllers/purchases_controller.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController extends GetxController {
  DatabaseApi api;

  @override
  void onInit() async {
    super.onInit();
    final database = await openDatabase(
      join(await getDatabasesPath(), 'premium_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE premium(is_premium TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    api = DatabaseApi(database: database);
    final isPremium = await api.getPremium();
    Get.find<PurchasesController>().paid(isPremium);
  }

  Future<void> setPremium(bool isPremium) async {
    final set = await api.setPremium(isPremium);
    if (set) {
      Get.find<PurchasesController>().paid(isPremium);
    }
  }
}
