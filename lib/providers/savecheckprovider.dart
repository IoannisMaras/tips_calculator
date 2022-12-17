import 'package:hooks_riverpod/hooks_riverpod.dart';

final checkProvider = StateNotifierProvider<CheckNotifier, bool>((ref) {
  return CheckNotifier();
});

class CheckNotifier extends StateNotifier<bool> {
  CheckNotifier() : super(true);

  void changeCheckToTrue() {
    state = true;
  }

  void changeCheckToFalse() {
    state = false;
  }
}
