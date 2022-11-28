import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tips_calculator/models/staffmodel.dart';

import '../models/tipshistorydetailsmodel.dart';
import '../models/tipshistorymodel.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get databse async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tipscalculator.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE staff(
          staff_id INTEGER PRIMARY KEY,
          name TEXT,
          weight REAL,
          icon_id INTEGER

        )
    ''');

    await db.execute('''
        CREATE TABLE tipshistory(
          tips_history_id INTEGER PRIMARY KEY,
          total_value REAL,
          date TEXT
        )
    ''');

    await db.execute('''
        CREATE TABLE tipshistory_details(
          details_id INTEGER PRIMARY KEY,
          tips_history_id INTEGER,
          name TEXT,
          count INTEGER,
          value REAL
          
        )
    ''');
  }

  //----------------------STAFF-----------------------------
  Future<List<StaffModel>> getAllStaffModels() async {
    Database db = await instance.databse;

    var staff = await db.query('staff', orderBy: 'staff_id');
    List<StaffModel> staffList = staff.isNotEmpty
        ? staff.map((e) => StaffModel.fromMap(e)).toList()
        : [];
    return staffList;
  }

  Future<int> addStaff(StaffModel staff) async {
    Database db = await instance.databse;

    return await db.insert("staff", staff.toMap());
  }

  Future<int> updateStaff(StaffModel staff) async {
    Database db = await instance.databse;

    return await db.update("staff", staff.toMap(),
        where: "staff_id = ?", whereArgs: [staff.id]);
  }

  Future<int> removeStaff(StaffModel staff) async {
    Database db = await instance.databse;

    return await db
        .delete("staff", where: "staff_id = ?", whereArgs: [staff.id]);
  }

  //----------------------TIPS_HISTORY-----------------------------
  Future<List<TipsHistoryModel>> getAllTipsHistory() async {
    Database db = await instance.databse;

    var tipsHistory = await db.query('tipshistory',
        orderBy: 'tips_history_id DESC', limit: 15);
    List<TipsHistoryModel> tipsHistoryArray = tipsHistory.isNotEmpty
        ? tipsHistory.map((e) => TipsHistoryModel.fromMap(e)).toList()
        : [];
    return tipsHistoryArray;
  }

  Future<int> addTipsHistory(TipsHistoryModel tipsHistory) async {
    Database db = await instance.databse;

    return await db.insert("tipshistory", tipsHistory.toMap());
  }

  Future<List<TipsHistoryModel>> loadMoreTipsHistory(int offset) async {
    Database db = await instance.databse;
    var tipsHistory = await db.query('tipshistory',
        orderBy: 'tips_history_id DESC', limit: 5, offset: offset);
    List<TipsHistoryModel> tipsHistoryArray = tipsHistory.isNotEmpty
        ? tipsHistory.map((e) => TipsHistoryModel.fromMap(e)).toList()
        : [];
    return tipsHistoryArray;
  }
//-------------------------TIPS_HISTORY_DETAILS--------------------------

  Future<List<TipsHistoryDetailsModel>> getTipsHistoryDetails(int id) async {
    Database db = await instance.databse;
    var tipsHistoryDetails = await db.query('tipshistory_details',
        where: "tips_history_id = ?", whereArgs: [id], orderBy: 'details_id');
    List<TipsHistoryDetailsModel> tipsHistoryDetailsArray =
        tipsHistoryDetails.isNotEmpty
            ? tipsHistoryDetails
                .map((e) => TipsHistoryDetailsModel.fromMap(e))
                .toList()
            : [];
    return tipsHistoryDetailsArray;
  }

  Future<int> addTipsHistoryDetails(
      TipsHistoryDetailsModel tipsHistoryDetails) async {
    Database db = await instance.databse;

    return await db.insert("tipshistory_details", tipsHistoryDetails.toMap());
  }
}
