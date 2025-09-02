import 'dart:math';
import 'package:postgres/postgres.dart';





// Helper to generate a random alphanumeric join code
Future<String> generateUniqueJoinCode(PostgreSQLConnection conn, {int length = 8}) async {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  String code;

  while (true) {
    code = List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();

    // Check if it exists in the DB
    final result = await conn.query(
      'SELECT 1 FROM team WHERE join_code = @code',
      substitutionValues: {'code': code},
    );

    if (result.isEmpty) {
      return code; // code is unique
    }
    // otherwise, loop and generate a new one
  }
}


// This function creates a team
// It takes the connection, and a team name.
// The function will create a join code for the team and can accept a expiration date, but it isn't needed. Users will not be automatically added within this function, but the creator must be added immediately after in some wrapper function or in the app itself.

Future<void> addTeam({
  required PostgreSQLConnection conn,
  required String name,
  DateTime? expiresAt,
}) async {
  final joinCode = await generateUniqueJoinCode(conn);

  await conn.query(
    '''
    INSERT INTO team (name, join_code, expires_at)
    VALUES (@name, @joinCode, @expiresAt)
    ''',
    substitutionValues: {
      'name': name,
      'joinCode': joinCode,
      'expiresAt': expiresAt?.toUtc(),
    },
  );

  print('Team "$name" added with join code "$joinCode" ✅');
}


