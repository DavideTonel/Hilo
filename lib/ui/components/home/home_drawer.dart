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
                    : Icon(Icons.account_circle_outlined, size: 45),
            title: Text(
              user?.username ?? "null",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Go to your profile",
              style: TextStyle(fontSize: 11),
            ),
            onTap: () {
              router.push("/home/profile");
            },
          ),
          const SizedBox(height: 5),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.import_export, size: 32),
            title: Text("Export evaluations"),
            onTap: () {
              router.push("/export/evaluations");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 32),
            title: Text("Settings"),
            onTap: () {
              router.push("/settings");
            },
          ),
        ],
      ),
    );
  }
}
