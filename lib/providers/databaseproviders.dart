import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../utilities/DatabaseHelper.dart';
import '../models/staffmodel.dart';
//import 'package:riverpod_003_async_value/repositories/fake_todo_repository.dart';
//import 'package:riverpod_003_async_value/repositories/todo_repository.dart';

//import 'models/models.dart';

final staffArrayNotifierProvider =
    StateNotifierProvider<StaffArrayNotifier, AsyncValue<List<StaffModel>>>(
        (ref) {
  return StaffArrayNotifier();
});

class StaffArrayNotifier extends StateNotifier<AsyncValue<List<StaffModel>>> {
  AsyncValue<List<StaffModel>>? previousState;

  StaffArrayNotifier([
    AsyncValue<List<StaffModel>>? staffArray,
  ]) : super(staffArray ?? const AsyncValue.loading()) {
    _retrieveStaff();
  }

  Future<void> _retrieveStaff() async {
    try {
      final staffArray = await DatabaseHelper.instance.getAllStaffModels();
      state = AsyncValue.data(staffArray);
    } catch (e, st) {
      _resetState();
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addStaff(StaffModel staff) async {
    _cacheState();
    state = state.whenData((staffArray) => [...staffArray, staff]);

    try {
      await DatabaseHelper.instance.addStaff(staff);
    } catch (e, st) {
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
