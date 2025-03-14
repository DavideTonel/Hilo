import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/navigation/global/navigation_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/home/home_page.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter(NavigationBloc navigationBloc) {
    router = GoRouter(
      initialLocation: "/home",
      routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => HomePage()
        ),
      ],
      redirect: (context, state) {
        final blocState = navigationBloc.state;
        switch (blocState) {
          case HomeUI _:
            return "/home";
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
