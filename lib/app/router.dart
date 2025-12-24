import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_keys.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';
import 'package:jibli_admin_food/presentation/auth/screens/login_page.dart';

import 'package:jibli_admin_food/presentation/main/main_screen.dart';
import 'package:jibli_admin_food/presentation/profile/screens/update_work_days.dart';

// Root navigator key (public so other modules can show dialogs)
final rootNavigatorKey = GlobalKey<NavigatorState>();


String _initialLocation() {
  // return Routes.main.path;

  FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
  if (user != null) {
    return Routes.main.path;
  }
  return Routes.logIn.path;
}

GoRouter router = GoRouter(
  initialLocation: _initialLocation(),
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  routes: _routes,
);

List<RouteBase> get _routes => <RouteBase>[
      // GoRoute(
      //   path: Routes.newPassword.path,
      //   name: Routes.newPassword.name,
      //   builder: (context, state) => NewPasswordScreen(
      //     code: state.queryParams["code"] ?? "",
      //   ),
      // ),
      // GoRoute(
      //   path: Routes.onBoarding.path,
      //   name: Routes.onBoarding.name,
      //   parentNavigatorKey: _rootNavigatorKey,
      //   builder: (context, state) => const OnBoardingScreen(),
      // ),

      // GoRoute(
      //   path: Routes.yourProfile.path,
      //   name: Routes.yourProfile.name,
      //   parentNavigatorKey: _rootNavigatorKey,
      //   builder: (context, state) => YourProfileScreen(),
      // ),

      // GoRoute(
      //   path: Routes.passwordManger.path,
      //   name: Routes.passwordManger.name,
      //   parentNavigatorKey: _rootNavigatorKey,
      //   builder: (context, state) => const PasswordManagerScreen(),
      // ),
      GoRoute(
        path: Routes.workDays.path,
        name: Routes.workDays.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => UpdateWorkDays(),
      ),

      GoRoute(
        name: Routes.logIn.name,
        path: Routes.logIn.path,
        builder: (context, state) {
          return login();
        },
      ),

      GoRoute(
          path: Routes.main.path,
          name: Routes.main.name,
          builder: (_, __) =>
              MainScreen()
          ,
          routes: [],
          parentNavigatorKey: _rootNavigatorKey),
    ];

enum Routes {
  logIn('login_page', '/login'),
  signUp('signup_page', 'signup'),

  home('home_page', '/home'),
  main('main_page', '/main'),

  profile('profile_page', '/profile'),

  fillProfile('fillProfile', 'fillProfile'),
  resetPassword("resetPassword", "resetPassword"),
  yourProfile(" yourProfile_page", "/yourProfile"),
  passwordManger("passwordManager_page", "/passwordManager"),
  workDays("workDays", "/workDays"),
  editemail("editemail", "/editemail"),
  forgetpassword("forgetpassword", "forgetpassword"),

  newPassword("newPassword", "/newPassword");

  const Routes(this.name, this.path);

  final String name;
  final String path;
}
