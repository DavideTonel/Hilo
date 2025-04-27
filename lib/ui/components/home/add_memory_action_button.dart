import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMemoryActionButton extends StatelessWidget {
  const AddMemoryActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary.withAlpha(245),
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => GoRouter.of(context).push("/memory/add"),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
