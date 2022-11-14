import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tips_calculator/models/staffmodel.dart';

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
      id INTEGER PRIMARY KEY
      name TEXT
      weight REAL
      iconId INTEGER

    )
''');
  }

  Future<List<StaffModel>> getAllStaffModels() async {
    Database db = await instance.databse;

    var staff = await db.query('staff', orderBy: 'id');
    List<StaffModel> staffList = staff.isNotEmpty
        ? staff.map((e) => StaffModel.fromMap(e)).toList()
        : [];
    return staffList;
  }
}