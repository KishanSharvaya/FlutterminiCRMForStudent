import 'dart:async';

import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:minicrm/Database/table_models/daily_activity/daily_activity_table.dart';
import 'package:minicrm/Database/table_models/followup/followup_tabel.dart';
import 'package:minicrm/Database/table_models/inquiry/inquiry_header.dart';
import 'package:minicrm/Database/table_models/inquiry/inquiry_product.dart';
import 'package:minicrm/Database/table_models/inquiry/temp_inquiry_product.dart';
import 'package:minicrm/Database/table_models/product/cart_product_table.dart';
import 'package:minicrm/Database/table_models/product/genral_product_table.dart';
import 'package:minicrm/Database/table_models/product/placed_order.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDbHelper {
  static OfflineDbHelper _offlineDbHelper;
  static Database database;

  static const TABLE_CUSTOMER = "customer";
  static const TABLE_GENERAL_PRODUCT = "general_product";
  static const TABLE_CART_PRODUCT = "cart_product";
  static const TABLE_PLACED_PRODUCT = "placed_product";
  static const TABLE_INQUIRY_HEADER = "inquiry_header";
  static const TABLE_INQUIRY_PRODUCT = "inquiry_product";
  static const TABLE_TEMP_INQUIRY_PRODUCT = "temp_inquiry_product";
  static const TABLE_FOLLOWUP = "followup";
  static const TABLE_DAILY_ACTIVITY = "daily_activity";

  static createInstance() async {
    _offlineDbHelper = OfflineDbHelper();
    database = await openDatabase(join(await getDatabasesPath(), 'miniCRM.db'),
        onCreate: (db, version) => _createDb(db), version: 9);
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

    db.execute(
      'CREATE TABLE $TABLE_PLACED_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, CustID INTEGER, ProductName TEXT, Qty INTEGER , UnitPrice TEXT , Specification TEXT , Unit TEXT , NetAmount TEXT , image BLOB, CreatedDate TEXT)',
    );

    db.execute(
      'CREATE TABLE $TABLE_INQUIRY_HEADER(id INTEGER PRIMARY KEY AUTOINCREMENT, CustID INTEGER, LeadNo TEXT, CustomerName INTEGER , LeadPriority TEXT , LeadStatus TEXT , LeadSource TEXT , Description TEXT , CloserReason TEXT, CreatedDate TEXT , CreatedBy TEXT , Customer_type TEXT)',
    );
    db.execute(
      'CREATE TABLE $TABLE_INQUIRY_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, CustID INTEGER, Inq_id  INTEGER, ProductName TEXT, Qty INTEGER , UnitPrice TEXT , Specification TEXT , Unit TEXT , NetAmount TEXT , CreatedDate TEXT)',
    );
    db.execute(
      'CREATE TABLE $TABLE_TEMP_INQUIRY_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, CustID INTEGER, Inq_id  INTEGER, ProductName TEXT, Qty INTEGER , UnitPrice TEXT , Specification TEXT , Unit TEXT , NetAmount TEXT , CreatedDate TEXT)',
    );

    db.execute(
      'CREATE TABLE $TABLE_FOLLOWUP(id INTEGER PRIMARY KEY AUTOINCREMENT, CustomerName TEXT , CustID INTEGER , FollowUpType TEXT , Priority TEXT , InqNo TEXT , MeetingNotes TEXT , NextFollowupDate TEXT , InquiryStatus TEXT , CloserReason TEXT , image BLOB , CreatedDate TEXT , CreatedBy TEXT )',
    );

    db.execute(
      'CREATE TABLE $TABLE_DAILY_ACTIVITY(id INTEGER PRIMARY KEY AUTOINCREMENT, CreatedDate TEXT , WorkingNotes TEXT , TypeOfWork TEXT , WorkingHours TEXT , CreatedBy TEXT )',
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

  ///Here Followup Tabel Implimentation
  Future<int> insertFollowup(FollowupModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_FOLLOWUP,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FollowupModel>> getAllFollowup() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(TABLE_FOLLOWUP);

    return List.generate(maps.length, (i) {
      /* String CustomerName;
  int CustID;
  String FollowUpType;
  String Priority;
  String InqNo;
  String MeetingNotes;
  String NextFollowupDate;
  String InquiryStatus;
  String CloserReason;
  Uint8List image;
  String CreatedDate;
  String CreatedBy;*/

      return FollowupModel(
        maps[i]['CustomerName'],
        maps[i]['CustID'],
        maps[i]['FollowUpType'],
        maps[i]['Priority'],
        maps[i]['InqNo'],
        maps[i]['MeetingNotes'],
        maps[i]['NextFollowupDate'],
        maps[i]['InquiryStatus'],
        maps[i]['CloserReason'],
        maps[i]['image'],
        maps[i]['CreatedDate'],
        maps[i]['CreatedBy'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateFollowup(FollowupModel model) async {
    final db = await database;

    await db.update(
      TABLE_FOLLOWUP,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteFollowup(int id) async {
    final db = await database;

    await db.delete(
      TABLE_FOLLOWUP,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<FollowupModel>> searchFollowup(String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_FOLLOWUP,
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

      return FollowupModel(
        maps[i]['CustomerName'],
        maps[i]['CustID'],
        maps[i]['FollowUpType'],
        maps[i]['Priority'],
        maps[i]['InqNo'],
        maps[i]['MeetingNotes'],
        maps[i]['NextFollowupDate'],
        maps[i]['InquiryStatus'],
        maps[i]['CloserReason'],
        maps[i]['image'],
        maps[i]['CreatedDate'],
        maps[i]['CreatedBy'],
        id: maps[i]['id'],
      );
    });
  }

  Future<List<FollowupModel>> getOnlyFollowupDetails(int custid) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db
        .query(TABLE_FOLLOWUP, where: 'id LIKE ?', whereArgs: ['%$custid%']);

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

      return FollowupModel(
        maps[i]['CustomerName'],
        maps[i]['CustID'],
        maps[i]['FollowUpType'],
        maps[i]['Priority'],
        maps[i]['InqNo'],
        maps[i]['MeetingNotes'],
        maps[i]['NextFollowupDate'],
        maps[i]['InquiryStatus'],
        maps[i]['CloserReason'],
        maps[i]['image'],
        maps[i]['CreatedDate'],
        maps[i]['CreatedBy'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> deleteAllFollowup() async {
    final db = await database;

    await db.delete(TABLE_FOLLOWUP);
  }

  ///Here Daily Acvtivity Tabel Implimentation
  Future<int> insertDailyActivity(DailyActivityModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_DAILY_ACTIVITY,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DailyActivityModel>> getAllDailyActivity() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_DAILY_ACTIVITY);

    return List.generate(maps.length, (i) {
      return DailyActivityModel(
        maps[i]['CreatedDate'],
        maps[i]['WorkingNotes'],
        maps[i]['TypeOfWork'],
        maps[i]['WorkingHours'],
        maps[i]['CreatedBy'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateDailyActivity(DailyActivityModel model) async {
    final db = await database;

    await db.update(
      TABLE_DAILY_ACTIVITY,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteDailyActivity(int id) async {
    final db = await database;

    await db.delete(
      TABLE_DAILY_ACTIVITY,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<DailyActivityModel>> searchDailyActivity(String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_DAILY_ACTIVITY,
        where: 'CustomerName LIKE ?', whereArgs: ['%$keyWord%']);

    return List.generate(maps.length, (i) {
      return DailyActivityModel(
        maps[i]['CreatedDate'],
        maps[i]['WorkingNotes'],
        maps[i]['TypeOfWork'],
        maps[i]['WorkingHours'],
        maps[i]['CreatedBy'],
        id: maps[i]['id'],
      );
    });
  }

  Future<List<DailyActivityModel>> getOnlyDailyActivityDetails(
      int custid) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_DAILY_ACTIVITY,
        where: 'id LIKE ?', whereArgs: ['%$custid%']);

    return List.generate(maps.length, (i) {
      return DailyActivityModel(
        maps[i]['CreatedDate'],
        maps[i]['WorkingNotes'],
        maps[i]['TypeOfWork'],
        maps[i]['WorkingHours'],
        maps[i]['CreatedBy'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> deleteAllDailyActivity() async {
    final db = await database;

    await db.delete(TABLE_DAILY_ACTIVITY);
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

  Future<List<CartProductModel>> getAllCartProduct(int custId) async {
    final db = await database;

    //final List<Map<String, dynamic>> maps = await db.query(TABLE_CART_PRODUCT);
    List<Map<String, dynamic>> maps = await db.query(TABLE_CART_PRODUCT,
        where: 'CustID LIKE ?', whereArgs: ['%$custId%']);

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

  ///Placed Product

  Future<int> insertPlacedProduct(PlacedProductModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_PLACED_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PlacedProductModel>> getAllPlacedProduct(int custId) async {
    final db = await database;

    //final List<Map<String, dynamic>> maps = await db.query(TABLE_CART_PRODUCT);
    List<Map<String, dynamic>> maps = await db.query(TABLE_PLACED_PRODUCT,
        where: 'CustID LIKE ?', whereArgs: ['%$custId%']);

    return List.generate(maps.length, (i) {
      return PlacedProductModel(
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

  /// Inquiry Header CRUD

  Future<int> insertInquiryHeader(InquiryHeaderModel model) async {
    final db = await database;

    final pkid = await db.insert(
      TABLE_INQUIRY_HEADER,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return pkid;
  }

  Future<List<InquiryHeaderModel>> getAllInquiryHeader() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_INQUIRY_HEADER);

    return List.generate(maps.length, (i) {
      /*

      int id;
  int CustID;
  String LeadNo;
  String CustomerName;
  String LeadPriority;
  String LeadStatus;
  String LeadSource;
  String Description;
  String CloserReason;
  String CreatedDate;
  String CreatedBy;
  String Customer_type;
      */

      return InquiryHeaderModel(
        maps[i]['CustID'],
        maps[i]['LeadNo'],
        maps[i]['CustomerName'],
        maps[i]['LeadPriority'],
        maps[i]['LeadStatus'],
        maps[i]['LeadSource'],
        maps[i]['Description'],
        maps[i]['CloserReason'],
        maps[i]['CreatedDate'],
        maps[i]['CreatedBy'],
        maps[i]['Customer_type'],
        id: maps[i]['id'],
      );
    });
  }

  Future<int> updateInquiryHeader(InquiryHeaderModel model) async {
    final db = await database;

    final pkid = await db.update(
      TABLE_INQUIRY_HEADER,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
    return pkid;
  }

  Future<void> deleteInquiryHeader(int id) async {
    final db = await database;

    await db.delete(
      TABLE_INQUIRY_HEADER,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<InquiryHeaderModel>> searchInquiryHeader(String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_INQUIRY_HEADER,
        where: 'CustomerName LIKE ?', whereArgs: ['%$keyWord%']);

    return List.generate(maps.length, (i) {
      return InquiryHeaderModel(
        maps[i]['CustID'],
        maps[i]['LeadNo'],
        maps[i]['CustomerName'],
        maps[i]['LeadPriority'],
        maps[i]['LeadStatus'],
        maps[i]['LeadSource'],
        maps[i]['Description'],
        maps[i]['CloserReason'],
        maps[i]['CreatedDate'],
        maps[i]['CreatedBy'],
        maps[i]['Customer_type'],
        id: maps[i]['id'],
      );
    });
  }

  Future<List<InquiryHeaderModel>> getOnlyInquiryHeaderDetails(
      int custid) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_INQUIRY_HEADER,
        where: 'CustID LIKE ?', whereArgs: ['%$custid%']);

    return List.generate(maps.length, (i) {
      return InquiryHeaderModel(
        maps[i]['CustID'],
        maps[i]['LeadNo'],
        maps[i]['CustomerName'],
        maps[i]['LeadPriority'],
        maps[i]['LeadStatus'],
        maps[i]['LeadSource'],
        maps[i]['Description'],
        maps[i]['CloserReason'],
        maps[i]['CreatedDate'],
        maps[i]['CreatedBy'],
        maps[i]['Customer_type'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> deleteAllInquiryHeader() async {
    final db = await database;

    await db.delete(TABLE_INQUIRY_HEADER);
  }

  /// Inquiry Product CRUD

  Future<int> insertInquiryProduct(InquiryProductModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_INQUIRY_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<InquiryProductModel>> getAllCustomerInquiryProduct(
      int custId) async {
    final db = await database;

    //final List<Map<String, dynamic>> maps = await db.query(TABLE_CART_PRODUCT);
    List<Map<String, dynamic>> maps = await db.query(TABLE_INQUIRY_PRODUCT,
        where: 'CustID LIKE ?', whereArgs: ['%$custId%']);

    return List.generate(maps.length, (i) {
      return InquiryProductModel(
        maps[i]['CustID'],
        maps[i]['Inq_id'],
        maps[i]['ProductName'],
        maps[i]['Qty'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['NetAmount'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<List<InquiryProductModel>> getAllInquiryProduct(int inqID) async {
    final db = await database;

    //final List<Map<String, dynamic>> maps = await db.query(TABLE_CART_PRODUCT);
    List<Map<String, dynamic>> maps = await db.query(TABLE_INQUIRY_PRODUCT,
        where: 'Inq_id LIKE ?', whereArgs: ['%$inqID%']);

    return List.generate(maps.length, (i) {
      return InquiryProductModel(
        maps[i]['CustID'],
        maps[i]['Inq_id'],
        maps[i]['ProductName'],
        maps[i]['Qty'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['NetAmount'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateInquiryProduct(InquiryProductModel model) async {
    final db = await database;

    await db.update(
      TABLE_INQUIRY_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteInquiryProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_INQUIRY_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteInquiryProductwithCustomerID(int id) async {
    final db = await database;

    await db.delete(
      TABLE_INQUIRY_PRODUCT,
      where: 'CustID = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteInquiryHeaderWithProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_INQUIRY_PRODUCT,
      where: 'Inq_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<InquiryProductModel>> searchInquiryProduct(String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_INQUIRY_PRODUCT,
        where: 'ProductName LIKE ?', whereArgs: ['%$keyWord%']);

    return List.generate(maps.length, (i) {
      return InquiryProductModel(
        maps[i]['CustID'],
        maps[i]['Inq_id'],
        maps[i]['ProductName'],
        maps[i]['Qty'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['NetAmount'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> deleteAllInquiryProduct() async {
    final db = await database;

    await db.delete(TABLE_INQUIRY_PRODUCT);
  }

  ///Temporary Inquiry Product CRUD TABLE_TEMP_INQUIRY_PRODUCT

  Future<int> insertTempInquiryProduct(TempInquiryProductModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_TEMP_INQUIRY_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TempInquiryProductModel>> getAllCustomerTempInquiryProduct(
      int custId) async {
    final db = await database;

    //final List<Map<String, dynamic>> maps = await db.query(TABLE_CART_PRODUCT);
    List<Map<String, dynamic>> maps = await db.query(TABLE_TEMP_INQUIRY_PRODUCT,
        where: 'CustID LIKE ?', whereArgs: ['%$custId%']);

    return List.generate(maps.length, (i) {
      return TempInquiryProductModel(
        maps[i]['CustID'],
        maps[i]['Inq_id'],
        maps[i]['ProductName'],
        maps[i]['Qty'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['NetAmount'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<List<TempInquiryProductModel>> getAllTempInquiryProduct() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_TEMP_INQUIRY_PRODUCT);
    /* List<Map<String, dynamic>> maps = await db.query(TABLE_TEMP_INQUIRY_PRODUCT,
        where: 'Inq_id LIKE ?', whereArgs: ['%$inqID%']);*/

    return List.generate(maps.length, (i) {
      return TempInquiryProductModel(
        maps[i]['CustID'],
        maps[i]['Inq_id'],
        maps[i]['ProductName'],
        maps[i]['Qty'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['NetAmount'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateTempInquiryProduct(TempInquiryProductModel model) async {
    final db = await database;

    await db.update(
      TABLE_TEMP_INQUIRY_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteTempInquiryProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_TEMP_INQUIRY_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTempInquiryHeaderWithProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_TEMP_INQUIRY_PRODUCT,
      where: 'Inq_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TempInquiryProductModel>> searchTempInquiryProduct(
      String keyWord) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_TEMP_INQUIRY_PRODUCT,
        where: 'ProductName LIKE ?', whereArgs: ['%$keyWord%']);

    return List.generate(maps.length, (i) {
      return TempInquiryProductModel(
        maps[i]['CustID'],
        maps[i]['Inq_id'],
        maps[i]['ProductName'],
        maps[i]['Qty'],
        maps[i]['UnitPrice'],
        maps[i]['Specification'],
        maps[i]['Unit'],
        maps[i]['NetAmount'],
        maps[i]['CreatedDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> deleteAllTempInquiryProduct() async {
    final db = await database;

    await db.delete(TABLE_TEMP_INQUIRY_PRODUCT);
  }
}
