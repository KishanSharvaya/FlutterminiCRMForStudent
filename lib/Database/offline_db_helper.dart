import 'dart:async';

import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDbHelper {
  static OfflineDbHelper _offlineDbHelper;
  static Database database;

  static const TABLE_CUSTOMER = "customer";

  static createInstance() async {
    _offlineDbHelper = OfflineDbHelper();
    database = await openDatabase(join(await getDatabasesPath(), 'miniCRM.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
  }

  static void _createDb(Database db) {
    db.execute(
      'CREATE TABLE $TABLE_CUSTOMER(id INTEGER PRIMARY KEY AUTOINCREMENT, CustomerName TEXT , Source TEXT , MobileNo1 TEXT , MobileNo2 TEXT , Email TEXT , Password TEXT , Address TEXT , City TEXT , State TEXT , Country TEXT , Pincode TEXT , CustomerType TEXT , CreatedDate TEXT)',
    );
  }

  static OfflineDbHelper getInstance() {
    return _offlineDbHelper;
  }

  ///Here Customer Table Implementation

  Future<int> insertCustomer(CustomerModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_CUSTOMER,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CustomerModel>> getAllCustomer() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(TABLE_CUSTOMER);

    return List.generate(maps.length, (i) {
      /* String CustomerName;
           String Source;
           String MobileNo1;
           String MobileNo2;
           String Email;
           String Password;
           String Address;
           String City;
           String State;
           String Country;
           String Pincode;
           String CustomerType;
           String CreatedDate;*/

      return CustomerModel(
        maps[i]['CustomerName'],
        maps[i]['Source'],
        maps[i]['MobileNo1'],
        maps[i]['MobileNo2'],
        maps[i]['Email'],
        maps[i]['Password'],
        maps[i]['Address'],
        maps[i]['City'],
        maps[i]['State'],
        maps[i]['Country'],
        maps[i]['Pincode'],
        maps[i]['CustomerType'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateCustomer(CustomerModel model) async {
    final db = await database;

    await db.update(
      TABLE_CUSTOMER,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteCustomer(int id) async {
    final db = await database;

    await db.delete(
      TABLE_CUSTOMER,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CustomerModel>> searchCustomer(String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.query(TABLE_CUSTOMER,
        where: 'CustomerName LIKE ?', whereArgs: ['%$keyWord%']);
  }

  Future<void> deleteAllCustomer() async {
    final db = await database;

    await db.delete(TABLE_CUSTOMER);
  }
}
