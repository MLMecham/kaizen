import 'package:postgres/postgres.dart';

Future<void> testPostgresConnection() async {
  final connection = PostgreSQLConnection(
    'your-db-host.rds.amazonaws.com', // host
    5432,                             // port
    'your_db_name',                  // database name
    username: 'your_username',
    password: 'your_password',
    useSSL: true,                    // important for RDS
  );

  try {
    await connection.open();
    print('✅ Connected to the database!');

    // Example query
    final result = await connection.query('SELECT NOW()');
    print('Result: ${result.first}');

    await connection.close();
  } catch (e) {
    print('❌ Error connecting to the database: $e');
  }
}
