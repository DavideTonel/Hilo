 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/login/login_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/input/confirm_button_widget.dart';
import 'package:roadsyouwalked_app/ui/components/input/labeled_checkbox_widget.dart';
import 'package:roadsyouwalked_app/ui/components/input/text_input_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

// [ ] should be a statefull widget to manage the text field controllers?
class LoginInfoPage extends StatelessWidget {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  
  LoginInfoPage({super.key});

  void _onLoginGranted(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final memoriesBloc = context.read<MemoryBloc>();
    final router = GoRouter.of(context);
    userBloc.add(
      Login(
        username: _usernameTextController.text,
        password: _passwordTextController.text,
      )
    );
    userBloc.stream.listen((state) {
      if (state is UserLoaded) {
        memoriesBloc.add(
          LoadMemories(
            userId: userBloc.state.user!.username,
            orderType: MemoryOrderType.timeline
          )
        );
        router.go("/home");
      }
    });
  }

  void _onLoginDenied(BuildContext context) {
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case LoginGranted _:
            _onLoginGranted(context);
            break;
          case LoginDenied _:
            _onLoginDenied(context);
            break;
          default:
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.route,
                size: 90,
              ),
              const Text(
                "Hilo",
                style: TextStyle(
                  fontSize: 25
                ),
              ),
              const SizedBox(height: AppSpacingConstants.xxl),
              TextInputWidget(
                textController: _usernameTextController,
                labelText: "Username"
              ),
              const SizedBox(height: AppSpacingConstants.xs),
              TextInputWidget(
                textController: _passwordTextController,
                labelText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: AppSpacingConstants.sm),
              LabeledCheckboxWidget(
                label: "Remember me",
                value: state.rememberUser,
                onChanged: (value) => context.read<LoginBloc>().add(SetRememberUser(value!))
              ),
              const SizedBox(height: AppSpacingConstants.xl),
              ConfirmButtonWidget(
                width: size.width * 0.70,
                height: size.height * 0.06,
                label: "Login",
                onPressed: () {
                  context.read<LoginBloc>().add(
                    LoginRequest(
                      _usernameTextController.text,
                      _passwordTextController.text
                    )
                  );
                }
              ),
              const SizedBox(height: AppSpacingConstants.xs),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).push("/auth/signup");
                },
                child: Text(
                  "Haven't you got an account? Sign up",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
