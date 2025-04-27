import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HomeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: Icon(
                Icons.person,
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
          fontSize: 22,
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
