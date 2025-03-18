import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/media/media_bloc.dart';
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
        BlocProvider(create: (context) => MediaBloc()),
      ],
      child: MyAppWithRouter()
    );
  }
}

class MyAppWithRouter extends StatelessWidget {
  const MyAppWithRouter({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MediaBloc>().add(CheckPermission());
    final appRouter = AppRouter();
    return MaterialApp.router(
      routerConfig: appRouter.router,
      title: "Roads You Walked",
    );
  }
}
