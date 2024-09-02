import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_actions_example/app.dart';
import 'package:quick_actions_example/quick_action_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  container.read(quickActionProvider.notifier).init();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}
