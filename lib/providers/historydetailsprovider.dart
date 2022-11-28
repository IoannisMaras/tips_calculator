import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tipshistorydetailsmodel.dart';
import '../utilities/databaseHelper.dart';

final historyDetailsProvider = StateNotifierProvider<
    HistoryDetailsValueNotifier,
    AsyncValue<List<TipsHistoryDetailsModel>>>((ref) {
  return HistoryDetailsValueNotifier();
});

class HistoryDetailsValueNotifier
    extends StateNotifier<AsyncValue<List<TipsHistoryDetailsModel>>> {
  // We initialize the list of todos to an empty list
  HistoryDetailsValueNotifier() : super(const AsyncData([]));

  AsyncValue<List<TipsHistoryDetailsModel>>? previousState;

  Future<void> getTipsHistoryDetails(int id) async {
    _cacheState();
    try {
      List<TipsHistoryDetailsModel> TipsHistoryDetailsArray =
          await DatabaseHelper.instance.getTipsHistoryDetails(id);

      state = AsyncData(TipsHistoryDetailsArray);
    } catch (e, st) {
      _resetState();
      state = AsyncValue.error(e, st);
    }
  }

  void _cacheState() {
    previousState = state;
  }

  void _resetState() {
    if (previousState != null) {
      state = previousState!;
      previousState = null;
    }
  }
}
