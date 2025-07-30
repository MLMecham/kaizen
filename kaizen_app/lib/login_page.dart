import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap body in Center to center child vertically & horizontally
      body: Align(
        alignment: Alignment(0,-0.33),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40), // page side padding
          child: Row(
            mainAxisSize: MainAxisSize.min,  // shrink Row to its children width
            crossAxisAlignment: CrossAxisAlignment.center, // center vertically
            children: [
              // LEFT SIDE: IMAGE with some padding
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blueGrey[50],
                  padding: const EdgeInsets.all(20), // padding inside image container
                  child: Image.asset(
                    'assets/kaizen_login_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 40), // space between image and login box

              // RIGHT SIDE: LOGIN FORM with rounded outline & padding
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // shrink vertically to content
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Login Header
                      Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),

                      // Row 2: Username
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(labelText: "Username"),
                      ),
                      SizedBox(height: 20),

                      // Row 3: Password
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                      SizedBox(height: 20),

                      // Row 4: Forgot link - centered inside box
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reset');
                          },
                          child: Text("Forgot username or password?"),
                        ),
                      ),

                      // Row 5: Login Button
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/goal');
                        },
                        child: Text("Log In"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
