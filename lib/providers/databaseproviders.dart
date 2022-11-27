import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/providers/badgeprovider.dart';

import '../utilities/databaseHelper.dart';
import '../models/staffmodel.dart';
//import 'package:riverpod_003_async_value/repositories/fake_todo_repository.dart';
//import 'package:riverpod_003_async_value/repositories/todo_repository.dart';

//import 'models/models.dart';

final staffArrayNotifierProvider =
    StateNotifierProvider<StaffArrayNotifier, AsyncValue<List<StaffModel>>>(
        (ref) {
  return StaffArrayNotifier(ref);
});

class StaffArrayNotifier extends StateNotifier<AsyncValue<List<StaffModel>>> {
  AsyncValue<List<StaffModel>>? previousState;

  final Ref ref;

  StaffArrayNotifier(
    this.ref, [
    AsyncValue<List<StaffModel>>? staffArray,
  ]) : super(staffArray ?? const AsyncValue.loading()) {
    _retrieveStaff();
  }

  Future<void> _retrieveStaff() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final staffArray = await DatabaseHelper.instance.getAllStaffModels();
      ref.read(badgeValueProvider.notifier).initList(staffArray);
      state = AsyncValue.data(staffArray);
      //
    } catch (e, st) {
      _resetState();
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addStaff(StaffModel staff) async {
    _cacheState();
    try {
      int id = await DatabaseHelper.instance.addStaff(staff);
      StaffModel finalStaff = StaffModel(
          id: id, name: staff.name, weight: staff.weight, iconId: staff.iconId);
      ref.read(badgeValueProvider.notifier).addBadge(finalStaff);
      state = state.whenData((staffArray) => [...staffArray, finalStaff]);
    } catch (e, st) {
      _resetState();
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateStaff(StaffModel uptadedStaff) async {
    _cacheState();
    try {
      int id = await DatabaseHelper.instance.updateStaff(uptadedStaff);
      state = state.whenData((staffArray) {
        return [
          for (final staff in staffArray)
            if (staff.id == uptadedStaff.id)
              StaffModel(
                  id: uptadedStaff.id,
                  name: uptadedStaff.name,
                  weight: uptadedStaff.weight,
                  iconId: uptadedStaff.iconId)
            else
              staff
        ];
      });
    } catch (e, st) {
      _resetState();
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeStaff(StaffModel staff, int id) async {
    _cacheState();

    ref.read(badgeValueProvider.notifier).removeBadge(staff.id as int);
    state = state.whenData(
      (value) => value.where((element) => element.id != staff.id).toList(),
    );
    try {
      await DatabaseHelper.instance.removeStaff(staff);
    } catch (e, st) {
      _resetState();
      ref.read(badgeValueProvider.notifier).addBadge(staff);
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
