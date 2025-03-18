import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/media/media_bloc.dart';
import 'package:roadsyouwalked_app/bloc/navigation/home/navigation_home_bloc.dart';
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
        BlocProvider(create: (context) => NavigationHomeBloc()),
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
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        // TODO first page will have to be a splash page, in here it must control if user is logged or not and dowload the necessary data
        context.read<MediaBloc>().add(CheckPermission());
        final appRouter = AppRouter(context.read<NavigationBloc>());
        return MaterialApp.router(
          routerConfig: appRouter.router,
          title: "Roads You Walked",
        );
      }
    );
  }
}
