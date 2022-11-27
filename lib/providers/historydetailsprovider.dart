import 'package:hooks_riverpod/hooks_riverpod.dart';

final historyDetailsProvider = StateNotifierProvider<HistoryDetailsValueNotifier, int>((ref) {
  return HistoryDetailsValueNotifier();
});

class HistoryDetailsValueNotifier extends StateNotifier<int> {
  // We initialize the list of todos to an empty list
  HistoryDetailsValueNotifier() : super(0);

  
  }