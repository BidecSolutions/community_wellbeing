import 'package:sqflite/sqflite.dart';
import 'connection.dart';

Future<void> insertToken(String deviceId, String token, String userId) async {
  final dbInstance = UserTokenDatabase();
  final dbClient = await dbInstance.database;

  await dbClient.insert('user_tokens', {
    'deviceId': deviceId,
    'token': token,
    'userId': userId,
  }, conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<Map<String, dynamic>?> getTokenByUserId() async {
  final dbInstance = UserTokenDatabase();
  final dbClient = await dbInstance.database;

  final result = await dbClient.query(
    'user_tokens',
    orderBy: 'id DESC',
    limit: 1,
  );

  if (result.isNotEmpty) {
    return result.first;
  }

  return null;
}

Future<void> insertLoginStatus({required String status}) async {
  final dbInstance = UserTokenDatabase();
  final db = await dbInstance.database;

  await db.insert('login_check', {
    'status': status,
  }, conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<String?> getLoginStatus() async {
  final dbInstance = UserTokenDatabase();
  final db = await dbInstance.database;

  final result = await db.query('login_check', orderBy: 'id DESC', limit: 1);

  if (result.isNotEmpty) {
    return result.first['status'] as String;
  }
  return null;
}
