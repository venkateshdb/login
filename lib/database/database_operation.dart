import 'package:login/network/api.dart';

import 'database_model.dart';
import 'database.dart';
import 'package:login/network/api_model.dart';
import 'dart:async';

class DatabaseOperation {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<UserDetail> authenticate({String phone, String password}) async{
    // login object
     UserLogin userLogin = UserLogin(phoneNo: phone, password: password);

     // query login api
    LoginModel resp = await getUserDetail(userLogin);
    UserDetail user = UserDetail(
      id: 0,
      name: resp.name,
      token: resp.token
    );
    return user;
  }
  Future<int> createUser(UserDetail user) async {
    final db = await dbProvider.database;

    var result = db.insert(tableName, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users = await db
          .query(tableName, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> hasToken(int id) async{
      bool result = await checkUser(id);
      return result;
  }


}