import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:roadsyouwalked_app/ui/components/user/profile_image_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class HomeDrawer extends StatelessWidget {
  final User? user;

  const HomeDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: AppSpacingConstants.xxl),
          ListTile(
            leading:
                user?.profileImagePath != null
                    ? ProfileImageWidget(
                      path: user!.profileImagePath!,
                      width: 58,
                    )
                    : Icon(
                      Icons.account_circle_outlined,
                      size: 45,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
            title: Text(
              user?.username ?? "null",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            subtitle: Text(
              "Go to your profile",
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(
                  context,
                ).colorScheme.onPrimaryContainer.withAlpha(150),
              ),
            ),
            onTap: () {
              router.push("/home/profile");
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 32,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            onTap: () {
              router.push("/settings");
            },
          ),
        ],
      ),
    );
  }
}
