import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_page.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_preview_page.dart';
import 'package:roadsyouwalked_app/ui/pages/entry_point/splash_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/home_page.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
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
          builder: (context, state) => CameraPage()
        ),
      ],
    );
  }
}
