import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/authentication_page.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/login/login_page.dart';
import 'package:roadsyouwalked_app/ui/pages/authentication/signup/signup_page.dart';
import 'package:roadsyouwalked_app/ui/pages/evaluation/export_evaluation_wrapper_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/home_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/detail/memories_detail_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_page.dart';
import 'package:roadsyouwalked_app/ui/pages/settings/appaerance_page.dart';
import 'package:roadsyouwalked_app/ui/pages/settings/settings_page.dart';
import 'package:roadsyouwalked_app/ui/pages/user/user_profile_page.dart';

/// A routing class that defines and initializes all application routes
/// using `GoRouter` for declarative navigation.
class AppRouter {
  /// The GoRouter instance used throughout the app to manage navigation.
  late final GoRouter router;

  /// Initializes the application router with a set of predefined routes.
  ///
  /// Sets the initial location to `/auth`, guiding users first to the
  /// authentication page.
  AppRouter() {
    router = GoRouter(
      initialLocation: "/auth",
      routes: [
        /// Home page route.
        GoRoute(
          path: "/home",
          builder: (context, state) => HomePage(),
        ),

        /// User profile route, accessible from the home page.
        GoRoute(
          path: "/home/profile",
          builder: (context, state) => UserProfilePage(),
        ),

        /// Base authentication route.
        GoRoute(
          path: "/auth",
          builder: (context, state) => AuthenticationPage(),
        ),

        /// Login route under the authentication flow.
        GoRoute(
          path: "/auth/login",
          builder: (context, state) => LoginPage(),
        ),

        /// Signup route under the authentication flow.
        GoRoute(
          path: "/auth/signup",
          builder: (context, state) => SignupPage(),
        ),

        /// Route for adding a new memory.
        GoRoute(
          path: "/memory/add",
          builder: (context, state) => NewMemoryPage(),
        ),

        /// Evaluations export page route.
        GoRoute(
          path: "/export/evaluations",
          builder: (context, state) => ExportEvaluationWrapperPage(),
        ),

        /// General settings page route.
        GoRoute(
          path: "/settings",
          builder: (context, state) => SettingsPage(),
        ),

        /// Appearance settings page route.
        GoRoute(
          path: "/settings/appaerance",
          builder: (context, state) => AppearancePage(),
        ),

        /// Memory detail view from the calendar.
        GoRoute(
          path: "/calendar/memories",
          builder: (context, state) => MemoriesDetailPage(),
        ),
      ],
    );
  }
}
