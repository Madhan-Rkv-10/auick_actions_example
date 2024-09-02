import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_actions_example/quick_action_providers.dart';
import 'package:quick_actions_example/screens/main_screen.dart';

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final quickActionNotifier = ref.read(quickActionProvider.notifier);

  // Manually trigger a refresh when quickAction state changes
  final goRouterRefreshNotifier = ValueNotifier<bool>(false);
  ref.listen<String>(
    quickActionProvider,
    (_, __) => goRouterRefreshNotifier.value = !goRouterRefreshNotifier.value,
  );

  return GoRouter(
    refreshListenable: goRouterRefreshNotifier,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'details',
            builder: (context, state) => const ProfileDetail(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final String quickAction = ref.read(quickActionProvider);
      if (quickAction == 'action_one' && state.fullPath != '/home') {
        quickActionNotifier.resetAction();
        return '/home';
      } else if (quickAction == 'action_two' && state.fullPath != '/profile') {
        quickActionNotifier.resetAction();
        return '/profile';
      }
      return null; // No redirection needed
    },
  );
});
