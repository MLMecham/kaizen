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
                        "Sign In",
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
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/goal');
                            },
                            child: Text("Sign In"),
                          )
                        )    
                      ),
                      
                      // Row 6: SSO Button
                      SizedBox(height: 12),
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ElevatedButton.icon(
                          // The 'onPressed' callback is required. It's what happens when you click the button.
                          // For now, it does nothing. An empty function means the button is enabled.
                          // If you set it to 'null', the button would be disabled.
                          onPressed: () {
                            // You can add actions here, like showing a message.
                            print('Directing you to the SSO login page...');
                          },

                          // The 'icon' property lets us add an icon to the button.
                          icon: const Icon(Icons.key),

                          // The 'label' is the main content of the button, usually text.
                          label: const Text('Continue with SSO'),

                          // THIS IS WHERE THE STYLING HAPPENS!
                          // We use the 'style' property and the ButtonStyle.styleFrom() helper.
                          style: ElevatedButton.styleFrom(
                            // foregroundColor is the color of the text and icon.
                            foregroundColor: Colors.black,

                            // backgroundColor is the button's fill color.
                            backgroundColor: Colors.white,

                            // padding adds space between the button's edge and its content.
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),

                            // shape defines the button's shape. We'll make it rounded.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            // elevation controls the size of the shadow.
                            elevation: 5,
                          )
                      ) 
                        
                      )
                      )
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
