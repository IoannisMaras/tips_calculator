import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/providers/badgeprovider.dart';
import 'package:tips_calculator/providers/historydetailsprovider.dart';
import 'package:tips_calculator/providers/staffarrayprovider.dart';

import '../models/tipshistorydetailsmodel.dart';
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
          .whenData((tipsHistoryArray) => [finalTips, ...tipsHistoryArray]);
      saveHistoryDetails(id, finalTips.value);
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

  Future<void> saveHistoryDetails(int tipsHistoryId, double totalTips) async {
    Map<int, int> badges = ref.read(badgeValueProvider.notifier).state;
    List<StaffModel>? staffArray;
    ref
        .read(staffArrayNotifierProvider)
        .whenData((value) => staffArray = value);
    if (staffArray != null) {
      double totalWeight =
          calculateTotalWeight(staffArray as List<StaffModel>, badges);
      for (int index = 0; index < staffArray!.length; index++) {
        // print(tipsHistoryId);
        // print(staffArray![index].name);
        // print(int.parse(badges[staffArray![index].id].toString()));
        // print(totalTips * (staffArray![index].weight / totalWeight));
        ref.read(historyDetailsProvider.notifier).addTipsHistory(
            TipsHistoryDetailsModel(
                tipsHistoryId: tipsHistoryId,
                name: staffArray![index].name,
                count: int.parse(badges[staffArray![index].id].toString()),
                value:
                    (totalTips * (staffArray![index].weight / totalWeight))));
      }
    }
  }

  double calculateTotalWeight(
      List<StaffModel> staffArray, Map<int, int> badgeArray) {
    double totalWeight = 0;
    for (StaffModel staff in staffArray) {
      totalWeight += staff.weight * badgeArray[staff.id as int]!;
    }
    return totalWeight;
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
