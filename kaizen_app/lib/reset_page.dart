import 'package:flutter/material.dart';

class ResetPage extends StatelessWidget {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your email address to receive a password reset link.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add logic to send a reset email here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reset link sent to ${emailController.text}')),
                );
              },
              child: Text('Send Reset Link'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back to previous page
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
