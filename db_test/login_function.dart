import 'package:postgres/postgres.dart';
import 'password_hash.dart';


// This function will try to log in the user
// It takes a connection, email, and password
// If it is successful it will return a map object containing the information from the user
// If it fails it will return null for now (we may want to make it explain why it failed later but this is fine for now)

Future<Map<String, dynamic>?> loginUser({
  required PostgreSQLConnection conn, // <-- add this
  required String email,
  required String password,
}) async {
  // 1. Query user by email
  final result = await conn.query(
    '''
    SELECT id, fname, lname, email, password_hash, team_id, role
    FROM app_user
    WHERE email = @email
    ''',
    substitutionValues: {'email': email},
  );

  if (result.isEmpty) {
    print('❌ No user found with email $email');
    return null;
  }

  final row = result.first.toColumnMap();

  // 2. Hash the provided password and compare
  final providedHash = hashPassword(password);
  if (row['password_hash'] != providedHash) {
    print('❌ Invalid password for $email');
    return null;
  }

  // 3. Return user info on success (omit password for safety)
  print('✅ Login successful for $email');
  return {
    'id': row['id'],
    'fname': row['fname'],
    'lname': row['lname'],
    'email': row['email'],
    'team_id': row['team_id'],
    'role': row['role'],
  };
}

