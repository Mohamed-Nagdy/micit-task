import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/auth/screens/login.dart';
import '../../presentation/screens/users/screens/add_edit_user.dart';
import '../../presentation/screens/users/screens/users_list.dart';

class AppRouter {
  GoRouter getRoutes({
    List<NavigatorObserver>? observers,
    String? initialLocation,
  }) {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: LoginPage.routeName,
          name: LoginPage.routeName,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: UsersList.routeName,
          name: UsersList.routeName,
          builder: (context, state) => const UsersList(),
        ),
        GoRoute(
          path: AddEditUserPage.routeName,
          name: AddEditUserPage.routeName,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            return AddEditUserPage(
              user: data?['user'],
            );
          },
        ),
      ],
    );
  }
}
