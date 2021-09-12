import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseApi {
  final Database database;
  String _id;

  DatabaseApi({this.database});

  Future<String> createUser() async {
    try {
      final users = await database.query('user');
      if (users.isNotEmpty) {
        _id = users[0]['id'] as String;
        return _id;
      }

      var uuid = const Uuid();
      _id = uuid.v4();

      await database.insert('user', {'id': _id, 'is_premium': "no"});
    } catch (e) {
      return '';
    }
  }

  Future<bool> setPremium(bool premium) async {
    try {
      database.insert('user', {'is_premium': premium == true ? "yes" : "no"});
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
