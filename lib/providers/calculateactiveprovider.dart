import 'package:hooks_riverpod/hooks_riverpod.dart';

final calculateActiveProvider =
    StateNotifierProvider<CalculateActiveNotifier, bool>((ref) {
  return CalculateActiveNotifier();
});

class CalculateActiveNotifier extends StateNotifier<bool> {
  CalculateActiveNotifier() : super(false);

  void changeCalculateActiveTo(bool flag) {
    state = flag;
  }
}
