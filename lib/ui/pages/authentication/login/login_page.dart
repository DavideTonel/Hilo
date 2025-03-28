import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/authentication/login/login_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/login/login_info_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: LoginInfoPage()
      ),
    );
  }
}
