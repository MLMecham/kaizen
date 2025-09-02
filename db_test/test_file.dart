import 'db_connection.dart';
import 'add_user.dart';
import 'join_team.dart';
import 'login_function.dart';
import 'add_team.dart';


void main() async {
  final conn = getConnection();
  await conn.open();

  try {
    // Test Add User
    // await addUser(
    //   conn: conn,
    //   fname: 'Mitchell',
    //   lname: 'Mecham',
    //   email: 'email3@gmail.com',
    //   password: 'east', // this will be hashed inside addUser
    // );

    // Test Login User
    final user = await loginUser(
      conn: conn,
      email: 'email3@gmail.com',
      password: 'east',
    );

    if (user != null) {
      print('User logged in: ${user['fname']} ${user['lname']} (${user['role']})');
    } else {
      print('Login failed.');
    }

    // Create Team
    await addTeam(
      conn: conn,
      name: 'Super Scooper', // your team name
      // expiresAt: DateTime(2025, 12, 31), // optional
    );

    // Test Join team wrong code
    // await joinTeam(conn: conn, 
    // userEmail: 'email3@gmail.com', 
    // joinCode: "Incorrect Code Lol"
    // );

    // Test join team nonexisting user correct code
    // await joinTeam(conn: conn, 
    // userEmail: 'ema@gmail.com', 
    // joinCode: "D02O9OU7"
    // );

    // Test Join team correct code
    // await joinTeam(conn: conn, 
    // userEmail: 'email3@gmail.com', 
    // joinCode: "D02O9OU7"
    // );

    //Test Join team correct code
    await joinTeam(conn: conn, 
    userEmail: 'email3@gmail.com', 
    joinCode: "NYATUD5L",
    makeOwner: true, 
    );

  } catch (e) {
    print('Error: $e');



  } finally {
    // Close the Connection
    await conn.close();
  }

  // Test Add User
  // await addUser(
  //   conn: conn,
  //   fname: 'Mitchell',
  //   lname: 'Mecham',
  //   email: 'email2@gmail.com',
  //   password: 'east',
  // );


  // Test Login


  

  // Create Vision

  // Create Milesone

  // Create Goal

  // 

  await conn.close();
}
