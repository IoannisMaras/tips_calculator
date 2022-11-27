import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tipshistorymodel.dart';
import '../utilities/databaseHelper.dart';
import '../models/staffmodel.dart';

final tipsHistoryArrayNotifierProvider = StateNotifierProvider<
    TipsHistoryArrayNotifier, AsyncValue<List<TipsHistoryModel>>>((ref) {
  return TipsHistoryArrayNotifier(ref);
});

class TipsHistoryArrayNotifier
    extends StateNotifier<AsyncValue<List<TipsHistoryModel>>> {
  AsyncValue<List<TipsHistoryModel>>? previousState;

  final Ref ref;

  TipsHistoryArrayNotifier(
    this.ref, [
    AsyncValue<List<TipsHistoryModel>>? staffArray,
  ]) : super(staffArray ?? const AsyncValue.loading()) {
    _retrieveTipsHistory();
  }

  Future<void> _retrieveTipsHistory() async {
    await Future.delayed(const Duration(seconds: 1));
    _cacheState();
    try {
      final tipsHistoryArray =
          await DatabaseHelper.instance.getAllTipsHistory();
      state = AsyncValue.data(tipsHistoryArray);
    } catch (e, st) {
      _resetState();
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addTipsHistory(TipsHistoryModel tipsHistory) async {
    _cacheState();
    try {
      int id = await DatabaseHelper.instance.addTipsHistory(tipsHistory);
      TipsHistoryModel finalTips = TipsHistoryModel(
          id: id, value: tipsHistory.value, date: tipsHistory.date);
      state = state
          .whenData((tipsHistoryArray) => [...tipsHistoryArray, finalTips]);
    } catch (e, st) {
      _resetState();
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMoreTipsHistory(int offset) async {
    _cacheState();
    try {
      List<TipsHistoryModel> finalTips =
          await DatabaseHelper.instance.loadMoreTipsHistory(offset);

      state = state
          .whenData((tipsHistoryArray) => [...tipsHistoryArray, ...finalTips]);
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
