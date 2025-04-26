import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:roadsyouwalked_app/api/firebase_api.dart';
import 'package:roadsyouwalked_app/bloc/authentication/auth_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/data/repository/memory_repository.dart';
import 'package:roadsyouwalked_app/data/repository/user_repository.dart';
import 'package:roadsyouwalked_app/firebase_options.dart';
import 'package:roadsyouwalked_app/navigation/app_router.dart';
import 'dart:developer' as dev;

import 'package:roadsyouwalked_app/ui/theme/app_theme.dart';

// TODO: how to create only ona UserRepository to all blocs?
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  const accessToken = String.fromEnvironment('ACCESS_TOKEN');

  dev.log("Mapbox token: $accessToken");
  MapboxOptions.setAccessToken(accessToken);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(UserRepository())..add(CheckAutoLogin())),
        BlocProvider(create: (context) => MemoryBloc(MemoryRepository())),
        BlocProvider(create: (context) => UserBloc(UserRepository())),
      ],
      child: MyAppWithRouter()
    );
  }
}

class MyAppWithRouter extends StatelessWidget {
  const MyAppWithRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      theme: AppTheme.lightTheme,      
      routerConfig: appRouter.router,
      title: "Roads You Walked",
    );
  }
}
