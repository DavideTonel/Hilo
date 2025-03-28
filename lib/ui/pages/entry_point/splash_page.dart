import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/private_storage/private_storage_bloc.dart';
import 'dart:developer' as dev;

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text("Splash Logo"));
    context.read<PrivateStorageBloc>().add(Initialize());
    return BlocConsumer<PrivateStorageBloc, PrivateStorageState>(
      listener: (context, state) {
        final GoRouter router = GoRouter.of(context);
        switch (state) {
          case PrivateStorageInitial _:
            dev.log("state initial");
            break;
          case PrivateStorageLoading _:
            dev.log("state loading");
            context.read<PrivateStorageBloc>().add(
              LoadImages(
                creatorId: "test_user_1"
              )
            );            
            break;
          case PrivateStorageLoaded _:
            dev.log("state loaded");
            router.go("/home");
            break;
        }
      },
      builder: (context, state) {
        return body;
      },
    );
  }
}
