import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter.of(context);
    final List<ListTile> items = [
      ListTile(
        leading: Icon(
          Icons.looks,
          size: 32,
        ),
        title: Text(
          "Appearance",
        ),
        onTap: () {
          router.push("/settings/appaerance");
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
