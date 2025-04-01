import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/auth_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text("Auth"));
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case Unauthenticated _:
            //context.read<AuthBloc>().add(RequestLogin());
            GoRouter.of(context).go("/auth/login");
            break;
          case Authenticated _:
            // [ ] go to home
            // [ ] load user
            break;
          default:
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: body,
        );
      },
    );
  }
}
