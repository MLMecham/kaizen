import 'package:postgres/postgres.dart';

// This function takes the connection, userEmail (we will get this from the frontend in a saved variable after they log in), and what the user enters as the join code
// The makeOwner field is to be used when a team is created to automatically make the owner join and be set as the owner of the team.
// The function first checks if the join code is valid, then if it is expired, and finally attempts to add the team to the app_user table as a foreign key.

Future<bool> joinTeam({
  required PostgreSQLConnection conn,
  required String userEmail,   // backend verified
  required String joinCode,
  bool makeOwner = false,      // optional, defaults to false
}) async {
  // 1. Look up the team by join code
  final teamResult = await conn.query(
    'SELECT id, expires_at FROM team WHERE join_code = @joinCode',
    substitutionValues: {'joinCode': joinCode},
  );

  if (teamResult.isEmpty) {
    print('❌ Invalid join code');
    return false;
  }

  final teamId = teamResult.first[0] as int;
  final expiresAt = teamResult.first[1] as DateTime?;
  if (expiresAt != null && expiresAt.isBefore(DateTime.now())) {
    print('❌ Join code has expired');
    return false;
  }

  // 2. Update the user's team_id and optionally role
  final userResult = await conn.query(
    '''
    UPDATE app_user
    SET team_id = @teamId
    ${makeOwner ? ", role = 'owner'" : ""}
    WHERE email = @email
    RETURNING id
    ''',
    substitutionValues: {
      'teamId': teamId,
      'email': userEmail,
    },
  );

  if (userResult.isEmpty) {
    print('❌ User not found');
    return false;
  }

  if (makeOwner) {
    print('✅ User $userEmail joined team $teamId as OWNER');
  } else {
    print('✅ User $userEmail joined team $teamId');
  }
  return true;
}

