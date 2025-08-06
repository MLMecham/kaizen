import 'package:postgres/postgres.dart';

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

    // Query all rows from the table
    final results = await connection.query('SELECT * FROM mitch_is_cool');

    if (results.isEmpty) {
      print('Table is empty. Inserting a new row...');
      
      // Insert a new row with id=1 and the specified day
      await connection.query(
        'INSERT INTO mitch_is_cool (id, day) VALUES (@id, @day)',
        substitutionValues: {
          'id': 1,
          'day': 'mitch super cool 8/4/2025',
        },
      );

      print('✅ Row inserted.');
    } else {
      for (final row in results) {
        // row[0] = id, row[1] = day
        print('id: ${row[0]}, day: ${row[1]}');
      }
    }

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