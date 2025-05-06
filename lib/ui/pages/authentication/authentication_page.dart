import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';

import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text("Auth"));
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        final router = GoRouter.of(context);
        switch (state) {
          case UserLoaded _:
            final memoriesBloc = context.read<MemoryBloc>();
            memoriesBloc.add(
              LoadMemories(
                userId: state.user!.username,
                orderType: MemoryOrderType.timeline,
              ),
            );
            router.go("/home");
            break;
          case UserNoAutoLogin _:
            GoRouter.of(context).go("/auth/login");
            break;
          default:
        }
      },
      builder: (context, state) {
        return Scaffold(body: body);
      },
    );
  }
}
