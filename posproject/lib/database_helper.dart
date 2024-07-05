import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        password TEXT,
        phone TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE services (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        service TEXT,
        price REAL,
        description TEXT
      )
    ''');

      await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        position TEXT,
        address TEXT,
        description TEXT
      )
    ''');
      await db.execute('''
      CREATE TABLE staffs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        position TEXT,
        address TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<int> insertService(Map<String, dynamic> service) async {
    Database db = await database;
    return await db.insert('services', service);
  }

  Future<int> insertCustomer(Map<String, dynamic> customer) async {
    Database db = await database;
    return await db.insert('customers', customer);
  }

    Future<int> insertStaff(Map<String, dynamic> staff) async {
    Database db = await database;
    return await db.insert('staffs', staff);
  }


  Future<List<Map<String, dynamic>>> getServices() async {
    Database db = await database;
    return await db.query('services');
  }

  Future<List<Map<String, dynamic>>> getCustomer() async {
    Database db = await database;
    return await db.query('customers');
  }

  
  Future<List<Map<String, dynamic>>> getStaff() async {
    Database db = await database;
    return await db.query('staffs');
  }

  Future<int> deleteService(int id) async {
    Database db = await database;
    return await db.delete('services', where: 'id = ?', whereArgs: [id]);
  }

   Future<int> deleteCustomers(int id) async {
    Database db = await database;
    return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteStaffs(int id) async {
    Database db = await database;
    return await db.delete('staffs', where: 'id = ?', whereArgs: [id]);
  }
}
