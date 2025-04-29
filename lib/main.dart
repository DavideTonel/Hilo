import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:roadsyouwalked_app/api/firebase_api.dart';
import 'package:roadsyouwalked_app/bloc/authentication/auth_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/settings/settings_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/data/repository/memory_repository.dart';
import 'package:roadsyouwalked_app/data/repository/user_repository.dart';
import 'package:roadsyouwalked_app/firebase_options.dart';
import 'package:roadsyouwalked_app/navigation/app_router.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';
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
        BlocProvider(
          create:
              (context) => AuthBloc(UserRepository())..add(CheckAutoLogin()),
        ),
        BlocProvider(create: (context) => MemoryBloc(MemoryRepository())),
        BlocProvider(create: (context) => UserBloc(UserRepository())),
        BlocProvider(create: (context) => SettingsBloc()..add(GetSettings())),
      ],
      child: MyAppWithRouter(),
    );
  }
}

class MyAppWithRouter extends StatelessWidget {
  const MyAppWithRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) {
        final prevSettings = previous.settings;
        final currSettings = current.settings;

        if (prevSettings == null || currSettings == null) {
          return true;
        }

        return prevSettings.theme != currSettings.theme ||
          prevSettings.themeSeedColor != currSettings.themeSeedColor;
      },
      builder: (context, state) {
        final settings = state.settings;
        final ThemeLight themeLight = settings?.theme ?? ThemeLight.system;
        final Color seedColor = settings?.themeSeedColor ?? Colors.blue;

        final ThemeData lightTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        );

        final ThemeData darkTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        );

        final ThemeMode themeMode;
        switch (themeLight) {
          case ThemeLight.light:
            themeMode = ThemeMode.light;
            break;
          case ThemeLight.dark:
            themeMode = ThemeMode.dark;
            break;
          case ThemeLight.system:
            themeMode = ThemeMode.system;
            break;
        }

        return MaterialApp.router(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          routerConfig: appRouter.router,
          title: "Roads You Walked",
        );
      },
    );
  }
}
