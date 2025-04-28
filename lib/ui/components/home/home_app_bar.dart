import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:roadsyouwalked_app/ui/components/user/profile_image_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final User? user;

  const HomeAppBar({super.key, required this.title, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leadingWidth: (user?.profileImagePath != null) ? 50 : kToolbarHeight,
      leading: Builder(
        builder:
            (context) =>
                user?.profileImagePath != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: AppSpacingConstants.sm, right: AppSpacingConstants.xs),
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Center(
                          child: ProfileImageWidget(
                            path: user!.profileImagePath!,
                            width: 30,
                          ),
                        ),
                      ),
                    )
                    : IconButton(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        size: 33,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
