import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_actions_example/quick_action_providers.dart';

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
