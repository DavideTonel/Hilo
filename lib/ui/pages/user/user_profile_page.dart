import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/update_user/update_user_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/user/user_profile_info_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserBloc(
        user: context.read<UserBloc>().state.user!,
        onUpdate: (username, password) async {
          context.read<UserBloc>()
          .add(
            Login(
              username: username,
              password: password
            )
          );
        }
      ),
      child: UserProfileInfoPage(),
    );
  }
}
