import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/user/profile_image_widget.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_page.dart';
import 'dart:developer' as dev;

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    dev.log("Rebuild");
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final Widget page;
        if (state is UserTakingProfileImage) {
          dev.log("State is UserTakinProfileImage");
          page = BlocProvider(
            create: (context) => CameraBloc()..add(InitCamera()),
            child: CameraPage(
              onSaveMedia: (file, remoteUri, mediaType) {
                context.read<UserBloc>().add(
                  UpdateProfileImage(profileImage: file),
                );
              },
            ),
          );
        } else if (state is UserLoaded) {
          final String? birthday = state.user?.birthday != null
              ? DateFormat("dd/mm/yyyy").format(DateTime.parse(state.user!.birthday))
              : null;
           
          page = Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Hello ${state.user?.firstName ?? "null"}"),
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
                          context.read<UserBloc>().add(TakeProfileImage());
                        },
                        child:
                            state.user?.profileImagePath != null
                                ? ProfileImageWidget(
                                  path: state.user!.profileImagePath!,
                                  width: 170,
                                )
                                : CircleAvatar(
                                  radius: 85,
                                  child: Icon(
                                    Icons.account_circle_outlined,
                                    size: 140,
                                  ),
                                ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
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
                    state.user?.username ?? "null",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _UserInfoTile(label: "First name", value: state.user?.firstName ?? "null"),
                  _UserInfoTile(label: "Last name", value: state.user?.lastName ?? "null"),
                  _UserInfoTile(
                    label: "Birthday",
                    value: birthday ?? "null"
                  ),
                  _UserInfoTile(label: "Username", value: state.user?.username ?? "null"),
                  _UserInfoTile(label: "Password", value: state.user?.password ?? "null"),
                  const SizedBox(height: 20),
                  if (state.user?.profileImagePath != null)
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<UserBloc>().add(
                          UpdateProfileImage(profileImage: null),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.errorContainer,
                        foregroundColor: theme.colorScheme.onErrorContainer,
                      ),
                      icon: const Icon(Icons.delete_outline),
                      label: const Text("Rimuovi immagine profilo"),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<UserBloc>().add(Logout());
                        GoRouter.of(context).go("/auth/login");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          dev.log("Else");
          page = Scaffold(
            body: Center(child: Text("Error")),
          );
        }
        return page;
      },
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
