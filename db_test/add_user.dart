import 'package:postgres/postgres.dart';
import 'password_hash.dart';
import 'db_connection.dart';


// The is the app_user table schema
// --CREATE TABLE app_user (
// --    id SERIAL PRIMARY KEY,
// --    fname TEXT NOT NULL,
// --    lname TEXT NOT NULL,
// --    email TEXT NOT NULL UNIQUE,
// --    password_hash TEXT NOT NULL,
// --    team_id INTEGER REFERENCES team(id) ON DELETE SET NULL,
// --    role TEXT NOT NULL DEFAULT 'member',
// --    is_excluded BOOLEAN NOT NULL DEFAULT FALSE,
// --    CHECK (role IN ('member', 'admin', 'manager', 'owner'))
// --);

import 'package:postgres/postgres.dart';
import 'password_hash.dart';

Future<void> addUser({
  required PostgreSQLConnection conn, // pass connection in
  required String fname,
  required String lname,
  required String email,
  required String password,
  int? teamId, // optional
  String role = 'member',
}) async {
  await conn.query(
    '''
    INSERT INTO app_user (fname, lname, email, password_hash, team_id, role)
    VALUES (@fname, @lname, @email, @passwordHash, @teamId, @role)
    ''',
    substitutionValues: {
      'fname': fname,
      'lname': lname,
      'email': email,
      'passwordHash': hashPassword(password),
      'teamId': teamId,
      'role': role,
    },
  );
  print('User $email added ✅');
}


// Dubug User
// fname: 'Mitchell',
//     lname: 'Mecham',
//     email: 'email@gmail.com',
//     passwordHash: 'east',
//     teamId: null, // can be null if no team
//     role: 'member',
