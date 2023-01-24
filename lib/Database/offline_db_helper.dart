import 'dart:async';

import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:minicrm/Database/table_models/product/cart_product_table.dart';
import 'package:minicrm/Database/table_models/product/genral_product_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDbHelper {
  static OfflineDbHelper _offlineDbHelper;
  static Database database;

  static const TABLE_CUSTOMER = "customer";
  static const TABLE_GENERAL_PRODUCT = "general_product";
  static const TABLE_CART_PRODUCT = "cart_product";

  static createInstance() async {
    _offlineDbHelper = OfflineDbHelper();
    database = await openDatabase(join(await getDatabasesPath(), 'miniCRM.db'),
        onCreate: (db, version) => _createDb(db), version: 5);
  }

  static void _createDb(Database db) {
    db.execute(
      'CREATE TABLE $TABLE_CUSTOMER(id INTEGER PRIMARY KEY AUTOINCREMENT, CustomerName TEXT , Source TEXT , MobileNo1 TEXT , MobileNo2 TEXT , Email TEXT , Password TEXT , Address TEXT , City TEXT , State TEXT , Country TEXT , Pincode TEXT , CustomerType TEXT , CreatedDate TEXT)',
    );

    db.execute(
      'CREATE TABLE $TABLE_GENERAL_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, ProductName TEXT, UnitPrice TEXT , Specification TEXT , Unit TEXT , image BLOB, CreatedDate TEXT)',
    );

    db.execute(
      'CREATE TABLE $TABLE_CART_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, CustID INTEGER, ProductName TEXT, Qty INTEGER , UnitPrice TEXT , Specification TEXT , Unit TEXT , NetAmount TEXT , image BLOB, CreatedDate TEXT)',
    );

    //TABLE_GENERAL_PRODUCT
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
    List<Map<String, dynamic>> maps = await db.query(TABLE_CUSTOMER,
        where: 'CustomerName LIKE ?', whereArgs: ['%$keyWord%']);

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

  Future<List<CustomerModel>> getOnlyCustomerDetails(int custid) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db
        .query(TABLE_CUSTOMER, where: 'id LIKE ?', whereArgs: ['%$custid%']);

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

  Future<void> deleteAllCustomer() async {
    final db = await database;

    await db.delete(TABLE_CUSTOMER);
  }

  /// General Product CRUD
  Future<int> insertGeneralProduct(ProductModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_GENERAL_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductModel>> getAllGeneralProduct() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_GENERAL_PRODUCT);

    return List.generate(maps.length, (i) {
      return ProductModel(
        maps[i]['ProductName'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['image'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateGeneralProduct(ProductModel model) async {
    final db = await database;

    await db.update(
      TABLE_GENERAL_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteGeneralProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_GENERAL_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ProductModel>> searchGeneralProduct(String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.query(TABLE_GENERAL_PRODUCT,
        where: 'ProductName LIKE ?', whereArgs: ['%$keyWord%']);
  }

  Future<void> deleteAllGeneralProduct() async {
    final db = await database;

    await db.delete(TABLE_GENERAL_PRODUCT);
  }

  /// CART Product CRUD
  Future<int> insertCartProduct(CartProductModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_CART_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartProductModel>> getAllCartProduct() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(TABLE_CART_PRODUCT);

    return List.generate(maps.length, (i) {
      return CartProductModel(
        maps[i]['CustID'],
        maps[i]['ProductName'],
        maps[i]['Qty'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['NetAmount'],
        maps[i]['image'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateCartProduct(CartProductModel model) async {
    final db = await database;

    await db.update(
      TABLE_CART_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteCartProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_CART_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ProductModel>> searchCartProduct(String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.query(TABLE_CART_PRODUCT,
        where: 'ProductName LIKE ?', whereArgs: ['%$keyWord%']);
  }

  Future<void> deleteAllCartProduct() async {
    final db = await database;

    await db.delete(TABLE_CART_PRODUCT);
  }
}
