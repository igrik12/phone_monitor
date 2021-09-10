import 'package:sqflite/sqflite.dart';

class DatabaseApi {
  final Database database;

  DatabaseApi({this.database});

  Future<bool> setPremium(bool premium) async {
    try {
      database
          .insert('premium', {'is_premium': premium == true ? "yes" : "no"});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getPremium() async {
    try {
      final premiums = await database.query('premium');
      if (premiums.isEmpty) return false;
      return premiums[0]["is_premium"] == "yes";
    } catch (e) {
      return false;
    }
  }
}
