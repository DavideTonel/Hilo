import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/signup/signup_bloc.dart';

class SignupInfoPage extends StatelessWidget {
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  SignupInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case SignupSuccess _:
            dev.log("signup success in ui, go to login");
            GoRouter.of(context).pop();
            break;
          case SignupFailure _:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Impossible to create user",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 159, 23, 14),
                duration: Duration(seconds: 3),
              ),
            );
            break;
          default:
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameTextController,
              decoration: InputDecoration(
                labelText: 'First name',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _lastNameTextController,
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
              controller: _usernameTextController,
              onChanged: (value) => context.read<SignupBloc>().add(
                UsernameCheckRequest(_usernameTextController.text)
              ),
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                errorText: state.validUsername || _usernameTextController.text.isEmpty ? null : "Username already taken",
              ),
            ),
            TextField(
              controller: _passwordTextController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SignupBloc>().add(
                  SignupRequest(
                    _firstNameTextController.text,
                    _lastNameTextController.text,
                    _usernameTextController.text,
                    _passwordTextController.text,
                  )
                );
              },
              child: Text('Sign up'),
            ),
          ],
        );
      }
    );
  }
}
