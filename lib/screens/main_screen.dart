import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quick_action_providers.dart';

class MainScreen extends StatefulHookConsumerWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
        child: Text('Main Screen'),
      ),
    );
  }
}
