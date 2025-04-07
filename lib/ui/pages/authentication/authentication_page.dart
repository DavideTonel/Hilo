import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/auth_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';

import 'dart:developer' as dev;

import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  _onAuthenticationGranted(BuildContext context, AuthState state) {
    final userBloc = context.read<UserBloc>();
    final memoriesBloc = context.read<MemoryBloc>();
    final router = GoRouter.of(context);
    userBloc.add(
      Login(
        username: state.username!,
        password: state.password!,
      )
    );
    userBloc.stream.listen((state) {
      if (state is UserLoaded) {
        memoriesBloc.add(
          LoadMemoriesByUserId(
            userId: userBloc.state.user!.username,
            orderType: MemoryOrderType.timeline
          )
        );
        router.go("/home");
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
