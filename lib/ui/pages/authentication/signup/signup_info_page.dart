import 'package:flutter/material.dart';

class SignupInfoPage extends StatelessWidget {
  const SignupInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'First name',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Last name',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Birthdate',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () {
            // Handle login logic here
          },
          child: Text('Sign in'),
        ),
      ],
    );
  }
}