import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMemoryActionButton extends StatelessWidget {
  const AddMemoryActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent[100],
      child: IconButton(
        onPressed: () => GoRouter.of(context).push("/memory/add"),    // TODO: voidcallback
        icon: Icon(
          Icons.add
        )
      )
    );
  }
}
