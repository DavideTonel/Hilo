import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/auth_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';

import 'dart:developer' as dev;

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  _onAuthenticationGranted(BuildContext context, AuthState state) {
    final userBloc = context.read<UserBloc>();
    final router = GoRouter.of(context);
    userBloc.add(
      Login(
        username: state.username!,
        password: state.password!,
      )
    );
    userBloc.stream.listen((state) {
      if (state is UserLoaded) {
        dev.log("Login success");
        router.go("/home");
      } else if (state is UserInitial) {
        dev.log("User not loaded");
      }
    });
  }

  _onAuthenticationDenied(BuildContext context) {
    GoRouter.of(context).go("/auth/login");
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text("Auth"));
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case Authenticated _:
            _onAuthenticationGranted(context, state);
            break;
          case Unauthenticated _:
            _onAuthenticationDenied(context);
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
