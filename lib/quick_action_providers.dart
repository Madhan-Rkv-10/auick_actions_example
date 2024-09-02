// Riverpod provider for quick action state
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_actions_example/quick_action_notifer.dart';

final quickActionProvider =
    StateNotifierProvider<QuickActionNotifier, String>((ref) {
  return QuickActionNotifier();
});
