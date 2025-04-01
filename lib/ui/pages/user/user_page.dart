import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Text("Hello, NAME"),
          MaterialButton(
            child: const Text("Logout"),
            onPressed: () {
              GoRouter.of(context).push("/auth/login");
            }
          )
        ],
      ),
    );
  }
}