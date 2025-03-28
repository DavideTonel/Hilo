import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/authentication/auth_bloc.dart';
import 'package:roadsyouwalked_app/bloc/private_storage/private_storage_bloc.dart';
import 'package:roadsyouwalked_app/navigation/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PrivateStorageBloc()),
      ],
      child: MyAppWithRouter()
    );
  }
}

class MyAppWithRouter extends StatelessWidget {
  const MyAppWithRouter({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(CheckAutoLogin());
    final appRouter = AppRouter();
    return MaterialApp.router(
      routerConfig: appRouter.router,
      title: "Roads You Walked",
    );
  }
}
