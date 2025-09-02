import 'package:postgres/postgres.dart';

// THis function creates a connection to the postgres AWS database.
// It does NOT open the connecion, just creates the object to use.

PostgreSQLConnection getConnection() {
  return PostgreSQLConnection(
    'kaizen-open-db.c7siei0gwupu.us-west-2.rds.amazonaws.com',
    5432,
    'postgres',
    username: 'postgres',
    password: 'OpenKaizen2025#',
    useSSL: true,
  );
}
