import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/authentication/signup/signup_bloc.dart';
import 'package:roadsyouwalked_app/data/repository/user/user_repository.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/signup/signup_info_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(UserRepository()),
      child: Scaffold(
        body: SignupInfoPage()
      ),
    );
  }
}
