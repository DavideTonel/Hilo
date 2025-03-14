import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/navigation/bloc/navigation_home_bloc.dart';
import 'package:roadsyouwalked_app/bloc/navigation/global/navigation_bloc.dart';
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
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => NavigationHomeBloc())
      ],
      child: MyAppWithRouter()
    );
  }
}

class MyAppWithRouter extends StatelessWidget {
  const MyAppWithRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final appRouter = AppRouter(context.read<NavigationBloc>());
        return MaterialApp.router(
          routerConfig: appRouter.router,
          title: "Roads You Walked",
        );
      }
    );
  }
}
