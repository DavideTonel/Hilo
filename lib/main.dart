import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:roadsyouwalked_app/api/firebase_api.dart';
import 'package:roadsyouwalked_app/bloc/memory/memories_detail_bloc/memories_detail_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/settings/settings_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/data/repository/memory/memory_repository.dart';
import 'package:roadsyouwalked_app/data/repository/user_repository.dart';
import 'package:roadsyouwalked_app/firebase_options.dart';
import 'package:roadsyouwalked_app/navigation/app_router.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';
import 'dart:developer' as dev;

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
        BlocProvider(create: (context) => MemoryBloc(MemoryRepository())),
        BlocProvider(create: (context) => UserBloc(UserRepository())..add(CheckAutoLogin())),
        BlocProvider(create: (context) => SettingsBloc()..add(GetSettings())),
        BlocProvider(create: (context) => MemoriesDetailBloc()),
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

        final colorSchemeLight = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        );
        final colorSchemeDark = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );

        final ThemeData lightTheme = ThemeData(
          colorScheme: colorSchemeLight,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(
            0xFFF5F5F5,
          ),
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarColor: colorSchemeLight.primary,
              systemNavigationBarColor: null,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            foregroundColor: colorSchemeLight.onSurfaceVariant,
            iconTheme: IconThemeData(color: colorSchemeLight.onSurfaceVariant),
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colorSchemeLight.onSurfaceVariant,
            ),
          ),
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: const Color(0xFFEDEDED),
            indicatorColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            labelTextStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: colorSchemeLight.onSurface,
              ),
            ),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              final isSelected = states.contains(WidgetState.selected);
              return IconThemeData(
                size: isSelected ? 28 : 26,
                color:
                    isSelected
                        ? colorSchemeLight.primary
                        : colorSchemeLight.onSurfaceVariant,
              );
            }),
          ),
          textTheme: Typography.blackCupertino.apply(
            bodyColor: colorSchemeLight.onSurfaceVariant,
            displayColor: colorSchemeLight.onSurfaceVariant,
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: const Color(0xFFF0F0F0),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            scrimColor: Colors.black38,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        );

        final ThemeData darkTheme = ThemeData(
          colorScheme: colorSchemeDark,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(
            255,
            22,
            22,
            22,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            foregroundColor: colorSchemeDark.onSurfaceVariant,
            iconTheme: IconThemeData(color: colorSchemeDark.onSurfaceVariant),
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colorSchemeDark.onSurfaceVariant,
            ),
          ),
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: const Color(
              0xFF1A1A1A,
            ).withAlpha(250),
            indicatorColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            labelTextStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: colorSchemeDark.onSurface,
              ),
            ),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              final isSelected = states.contains(WidgetState.selected);
              return IconThemeData(
                size: isSelected ? 28 : 26,
                color:
                    isSelected
                        ? colorSchemeDark.primary
                        : colorSchemeDark.onSurfaceVariant,
              );
            }),
          ),
          textTheme: Typography.whiteCupertino.apply(
            bodyColor: colorSchemeDark.onSurfaceVariant,
            displayColor: colorSchemeDark.onSurfaceVariant,
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: const Color(0xFF1A1A1A),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            scrimColor: Colors.black54,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
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
