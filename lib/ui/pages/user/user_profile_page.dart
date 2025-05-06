import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/update_user/update_user_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/user/profile_image_widget.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserBloc(
        user: context.read<UserBloc>().state.user!,
        onUpdate: () => context.read<UserBloc>()
          .add(
            Login(
              username: context.read<UserBloc>().state.user!.username,
              password: context.read<UserBloc>().state.user!.password
            )
          ),
      ),
      child: UserProfileInfoPage(),
    );
  }
}

class _UserInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _UserInfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileInfoPage extends StatelessWidget {
  const UserProfileInfoPage({super.key});

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
        child: Icon(
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
          final String birthday = DateFormat(
            "dd/mm/yyyy",
          ).format(DateTime.parse(state.user.birthday));

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
                        child: _getProfileImageWidget(context)
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Icon(
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
                  _UserInfoTile(
                    label: "First name",
                    value: state.user.firstName,
                  ),
                  _UserInfoTile(
                    label: "Last name",
                    value: state.user.lastName,
                  ),
                  _UserInfoTile(label: "Birthday", value: birthday),
                  _UserInfoTile(
                    label: "Username",
                    value: state.user.username,
                  ),
                  _UserInfoTile(
                    label: "Password",
                    value: state.user.password,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      onPressed: () {
                        context.read<UpdateUserBloc>().add(
                          UpdateUser(),
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
