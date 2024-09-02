// StateNotifier to manage quick action state
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_actions/quick_actions.dart';

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
        localizedTitle: 'Profile Details Screen',
        icon: 'ic_launcher',
      ),
    ]);
  }
}
