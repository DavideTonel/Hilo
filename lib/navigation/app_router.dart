import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/navigation/global/navigation_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_preview_page.dart';
import 'package:roadsyouwalked_app/ui/pages/entry_point/splash_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/home_page.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter(NavigationBloc navigationBloc) {
    router = GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => HomePage()
        ),
        GoRoute(
          path: "/",
          builder: (context, state) => SplashPage()
        ),
        GoRoute(
          path: "/memory/add/photo",
          builder: (context, state) => NewMemoryPage()
        ),
      ],
      redirect: (context, state) {
        final blocState = navigationBloc.state;
        switch (blocState) {
          case HomeUI _:
            return "/home";
          case SplashUI _:
            return "/";
          case CameraUI _:
            return "/memory/add/photo";
        }
      },
      refreshListenable: GoRouterRefreshStream(navigationBloc.stream)
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    stream.listen((_) {
      notifyListeners();
    });
  }
}
