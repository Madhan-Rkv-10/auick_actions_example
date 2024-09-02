import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// StateNotifier to manage quick action state
class QuickActionNotifier extends StateNotifier<String> {
  QuickActions quickActions = const QuickActions();

  QuickActionNotifier() : super('');

  void resetAction() {
    state = '';
  }

  void init() {
    quickActions.initialize((String shortcutType) {
      state = shortcutType;
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Home Screen',
        icon: 'ic_launcher',
      ),
      const ShortcutItem(
        type: 'action_two',
        localizedTitle: 'Profile Screen',
        icon: 'ic_launcher',
      ),
    ]);
  }
}

// Riverpod provider for quick action state
final quickActionProvider =
    StateNotifierProvider<QuickActionNotifier, String>((ref) {
  return QuickActionNotifier();
});

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  container.read(quickActionProvider.notifier).init();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quickActionNotifier = ref.read(quickActionProvider.notifier);

    // Manually trigger a refresh when quickAction state changes
    final goRouterRefreshNotifier = ValueNotifier<bool>(false);
    ref.listen<String>(
      quickActionProvider,
      (_, __) => goRouterRefreshNotifier.value = !goRouterRefreshNotifier.value,
    );

    final GoRouter router = GoRouter(
      refreshListenable: goRouterRefreshNotifier,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MyHomePage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
      redirect: (context, state) {
        final String quickAction = ref.read(quickActionProvider);
        if (quickAction == 'action_one' && state.fullPath != '/home') {
          quickActionNotifier.resetAction();
          return '/home';
        } else if (quickAction == 'action_two' &&
            state.fullPath != '/profile') {
          quickActionNotifier.resetAction();
          return '/profile';
        }
        return null; // No redirection needed
      },
    );

    return MaterialApp.router(
      title: 'Flutter Quick Actions Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String shortcut = ref.watch(quickActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quick Actions Example - $shortcut",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text('On home screen, long press the app icon to '
            'get Action one or Action two options. Tapping on that action should  '
            'set the toolbar title.'),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: const Center(
        child: Text('Welcome to Home Screen'),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
      ),
      body: const Center(
        child: Text('Welcome to Profile Screen'),
      ),
    );
  }
}
