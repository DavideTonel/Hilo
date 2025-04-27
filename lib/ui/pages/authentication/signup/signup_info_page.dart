import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/signup/signup_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/input/confirm_button_widget.dart';
import 'package:roadsyouwalked_app/ui/components/input/text_input_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class SignupInfoPage extends StatelessWidget {
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  SignupInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case SignupSuccess _:
            GoRouter.of(context).pop();
            break;
          case SignupFailure _:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Impossible to create user",
                  style: TextStyle(color: Colors.white),
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
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      size: size.width * 0.4,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      
                    },
                  ),
                  Positioned(
                    bottom: size.width * 0.05,
                    left: size.width * 0.15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Add photo",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              TextInputWidget(
                textController: _firstNameTextController,
                labelText: "First name",
              ),
              const SizedBox(height: AppSpacingConstants.xs),
              TextInputWidget(
                textController: _lastNameTextController,
                labelText: "Last name",
              ),
              const SizedBox(height: AppSpacingConstants.xs),
              // TODO: use a date picker
              TextField(
                decoration: InputDecoration(
                  labelText: 'Birthdate',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacingConstants.xs),
              TextInputWidget(
                textController: _usernameTextController,
                labelText: "Username",
                onChanged:
                    (value) => context.read<SignupBloc>().add(
                      UsernameCheckRequest(_usernameTextController.text),
                    ),
                isValid:
                    state.validUsername || _usernameTextController.text.isEmpty,
                errorText:
                    state.validUsername ? null : "Username already taken",
              ),
              const SizedBox(height: AppSpacingConstants.xs),
              TextInputWidget(
                textController: _passwordTextController,
                labelText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: AppSpacingConstants.xl),
              ConfirmButtonWidget(
                width: size.width * 0.70,
                onPressed: () {
                  context.read<SignupBloc>().add(
                    SignupRequest(
                      _firstNameTextController.text,
                      _lastNameTextController.text,
                      _usernameTextController.text,
                      _passwordTextController.text,
                    ),
                  );
                },
                label: "Signup",
              ),
            ],
          ),
        );
      },
    );
  }
}
