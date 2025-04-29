import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/authentication_page.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/login/login_page.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/signup/signup_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/home_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/detail/memories_detail_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_page.dart';
import 'package:roadsyouwalked_app/ui/pages/settings/appaerance_page.dart';
import 'package:roadsyouwalked_app/ui/pages/settings/settings_page.dart';
import 'package:roadsyouwalked_app/ui/pages/user/user_profile_page.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: "/auth",
      routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => HomePage()
        ),
        GoRoute(
          path: "/home/profile",
          builder: (context, state) => UserProfilePage()
        ),
        GoRoute(
          path: "/auth",
          builder: (context, state) => AuthenticationPage()
        ),
        GoRoute(
          path: "/auth/login",
          builder: (context, state) => LoginPage()
        ),
        GoRoute(
          path: "/auth/signup",
          builder: (context, state) => SignupPage()
        ),
        GoRoute(
          path: "/memory/add",
          builder: (context, state) => NewMemoryPage()
        ),
        GoRoute(
          path: "/settings",
          builder: (context, state) => SettingsPage()
        ),
        GoRoute(
          path: "/settings/appaerance",
          builder: (context, state) => AppaerancePage()
        ),
        GoRoute(
          path: "/calendar/memories",
          builder: (context, state) => MemoriesDetailPage()
        ),
      ],
    );
  }
}
