import 'package:postgres/postgres.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

// Define the hashPassword function
String hashPassword(String password) {
  final bytes = utf8.encode(password);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
// Define the add user function
Future<void> addUser({
  required PostgreSQLConnection connection,
  required String username,
  String? email,
  required String password,   // <-- Now accepts plain password
  String role = 'user',
}) async {
  try {
    if (connection.isClosed) {
      await connection.open();
    }

    // Hash the password here
    final passwordHash = hashPassword(password);

    final query = '''
      INSERT INTO "user" (username, email, password_hash, role)
      VALUES (@username, @email, @passwordHash, @role)
      RETURNING id;
    ''';

    final result = await connection.query(
      query,
      substitutionValues: {
        'username': username,
        'email': email,
        'passwordHash': passwordHash,
        'role': role,
      },
    );

    if (result.isNotEmpty) {
      final newUserId = result.first[0];
      print('✅ User added successfully with id: $newUserId');
    } else {
      print('⚠️ User was not added.');
    }
  } catch (e) {
    print('❌ Error adding user: $e');
  }
}

Future<void> printAllUsers(PostgreSQLConnection connection) async {
  try {
    final results = await connection.query('SELECT id, username, email, role, created_at, password_hash FROM "user"');

    if (results.isEmpty) {
      print('No users found.');
      return;
    }

    print('Users:');
    for (final row in results) {
      final id = row[0];
      final username = row[1];
      final email = row[2] ?? 'No email';
      final role = row[3];
      final createdAt = row[4];
      final pass = row[5];

      print('ID: $id, Username: $username, Email: $email, Role: $role, Created At: $createdAt, pass: $pass');
    }
  } catch (e) {
    print('Error fetching users: $e');
  }
}


Future<bool> verifyUserPassword({
  required PostgreSQLConnection connection,
  required String username,
  required String passwordToCheck,
}) async {
  try {
    if (connection.isClosed) {
      await connection.open();
    }

    // Query to get the stored hashed password for the username
    final result = await connection.query(
      'SELECT password_hash FROM "user" WHERE username = @username',
      substitutionValues: {'username': username},
    );

    if (result.isEmpty) {
      print('User not found');
      return false; // No user with this username
    }

    final storedHash = result.first[0] as String;

    // Hash the input password
    final inputHash = hashPassword(passwordToCheck);

    // Compare hashes
    if (storedHash == inputHash) {
      print('Password verified successfully.');
      return true;
    } else {
      print('Password does not match.');
      return false;
    }
  } catch (e) {
    print('Error verifying password: $e');
    return false;
  }
}


Future<void> main() async {
  final connection = PostgreSQLConnection(
    'kaizen-open-db.c7siei0gwupu.us-west-2.rds.amazonaws.com', // e.g. kaizen-db.cluster-xyz.us-east-2.rds.amazonaws.com
    5432,
    'postgres',
    username: 'postgres',
    password: 'OpenKaizen2025#',
    useSSL: true,
  );

   try {
    await connection.open();
    print('✅ Connected to the database!');

    

    // Add a user
    // await addUser(
    //   connection: connection,
    //   username: 'mitch3',
    //   email: 'mitch4@example.com',
    //   password: 'easy',
    // );

    // Print all users
  await printAllUsers(connection);

    // Verify a user password
    await verifyUserPassword(
      connection: connection, 
      username: "mitch", 
      passwordToCheck: "easy");

      
      await connection.close();
  } catch (e) {
    print('❌ Error: $e');
  }
}

// await connection.query('''
//       CREATE TABLE IF NOT EXISTS mitch_is_cool (
//         id SERIAL PRIMARY KEY,
//         day VARCHAR(30)
//       )
//     ''');



// const createTableQuery = '''
//       CREATE TABLE IF NOT EXISTS user (
//         id SERIAL PRIMARY KEY,
//         username VARCHAR(50) UNIQUE NOT NULL,
//         email VARCHAR(100) UNIQUE,
//         password_hash TEXT NOT NULL,
//         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
//         last_login TIMESTAMP,
//         is_active BOOLEAN DEFAULT TRUE,
//         role VARCHAR(20) DEFAULT 'user',
//         email_verified BOOLEAN DEFAULT FALSE
//       );
//     ''';

//     await connection.execute(createTableQuery);
//     print('📦 Table checked/created successfully!');
