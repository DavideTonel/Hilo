import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Profile")),
          body: Column(
            children: [
              Text("Hello, ${state.user?.username}"),
              MaterialButton(
                child: const Text("Logout"),
                onPressed: () {
                  context.read<UserBloc>().add(Logout());
                  GoRouter.of(context).go("/auth/login");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
