import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/login/login_bloc.dart';

class LoginInfoPage extends StatelessWidget {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  

  LoginInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case LoginSuccess _:
            GoRouter.of(context).go("/home");
            break;
          case LoginFailure _:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Wrong username or password",
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
            Text("Roads You Walked Logo"),
            TextField(
              controller: _usernameTextController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
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
            Checkbox(
              value: state.rememberUser,
              onChanged: (value) => context.read<LoginBloc>().add(SetRememberUser(value!))
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(
                  LoginRequest(
                    _usernameTextController.text,
                    _passwordTextController.text
                  )
                );
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).push("/auth/signup");
              },
              child: Text('Haven\'t you got an account? Sign up'),
            ),
          ],
        );
      },
    );
  }
}
