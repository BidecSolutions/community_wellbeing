import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserTokenDatabase {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final fullPath = join(dbPath, 'user_tokens.db');

    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE user_tokens (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              deviceId TEXT,
              token TEXT,
              userId TEXT
            )
        ''');
        await db.execute('''
          CREATE TABLE login_check (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            status TEXT
          )
        ''');
      },
    );
  }
}
