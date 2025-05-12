import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/update_user/update_user_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/input/date_selector_widget.dart';
import 'package:roadsyouwalked_app/ui/components/input/text_input_widget.dart';
import 'package:roadsyouwalked_app/ui/components/user/profile_image_widget.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_page.dart';

class UserProfileInfoPage extends StatefulWidget {
  const UserProfileInfoPage({super.key});

  @override
  State<UserProfileInfoPage> createState() => _UserProfileInfoPageState();
}

class _UserProfileInfoPageState extends State<UserProfileInfoPage> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late String birthdayController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UpdateUserBloc>().state.user;
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    usernameController = TextEditingController(text: user.username);
    passwordController = TextEditingController(text: user.password);
    birthdayController = user.birthday;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _getProfileImageWidget(BuildContext context) {
    File? profileImage = context.read<UpdateUserBloc>().state.newProfileImage;
    if (profileImage != null) {
      return ProfileImageWidget(
        path: profileImage.path,
        width: 170,
      );
    } else {
      return CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(55),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        radius: 85,
        child: const Icon(
          Icons.account_circle_outlined,
          size: 140,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UpdateUserBloc, UpdateUserState>(
      builder: (context, state) {
        final Widget page;
        if (state is UserTakingProfileImage) {
          page = BlocProvider(
            create: (context) => CameraBloc()..add(InitCamera()),
            child: CameraPage(
              onSaveMedia: (file, remoteUri, mediaType) {
                context.read<UpdateUserBloc>().add(
                  AddProfileImage(profileImage: file),
                );
              },
            ),
          );
        } else {
          page = Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Hello ${state.user.firstName}!"),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<UpdateUserBloc>().add(TakeProfileImage());
                        },
                        child: _getProfileImageWidget(context),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.user.username,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (state.newProfileImage != null) ...[
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<UpdateUserBloc>().add(
                          AddProfileImage(profileImage: null),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.errorContainer,
                        foregroundColor: theme.colorScheme.onErrorContainer,
                      ),
                      icon: const Icon(Icons.delete_outline),
                      label: const Text("Rimuovi immagine profilo"),
                    ),
                    const SizedBox(height: 20),
                  ],
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      spacing: 20.0,
                      children: [
                        TextInputWidget(
                      textController: firstNameController,
                      labelText: "First name",
                    ),
                    TextInputWidget(
                      textController: lastNameController,
                      labelText: "Last name",
                    ),
                    DateSelectorWidget(
                      label: "Birthday",
                      value: DateTime.parse(birthdayController),
                      onDateSelected: (date) {
                        setState(() {
                          birthdayController = date.toIso8601String();
                        });
                      },
                    ),
                    TextInputWidget(
                      textController: passwordController,
                      labelText: "Password",
                    ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<UpdateUserBloc>().add(
                        UpdateUser(
                          user: state.user.copyWith(
                            newUsername: state.user.username,
                            newPassword: passwordController.text,
                            newFirstName: firstNameController.text,
                            newLastName: lastNameController.text,
                            newBirthday: birthdayController
                          )
                        ),
                      );
                      GoRouter.of(context).go("/home");
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text("Save changes"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<UserBloc>().add(Logout());
                        GoRouter.of(context).go("/auth/login");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.errorContainer,
                        foregroundColor: theme.colorScheme.onErrorContainer,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      icon: Icon(
                        Icons.logout,
                        color: theme.colorScheme.onErrorContainer,
                      ),
                      label: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return page;
      },
    );
  }
}
