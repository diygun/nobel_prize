import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

enum AddUser { SUCESS, FAIL }

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    print("Database path : " + dbPath);

    String path = join(dbPath, 'NobelPrize.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            username TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<AddUser> addUser(User user) async {
    final db = await database;

    final List<Map<String, dynamic>> existingUsers = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [user.username],
    );

    if (existingUsers.isNotEmpty) {
      // User already exists
      return AddUser.FAIL;
    }

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    // print all current data inside the table
    final List<Map<String, dynamic>> allUsers = await db.query('users');
    print(allUsers);
    return AddUser.SUCESS;
  }

  Future<bool> userExists(String username, String password) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }
}