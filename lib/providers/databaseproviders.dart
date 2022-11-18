import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../DatabaseHelper.dart';
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
  StaffArrayNotifier([
    AsyncValue<List<StaffModel>>? staffArray,
  ]) : super(staffArray ?? const AsyncValue.loading()) {
    _retrieveStaff();
  }

  AsyncValue<List<int>>? previousState;

  Future<void> _retrieveStaff() async {
    try {
      final staffArray = await DatabaseHelper.instance.getAllStaffModels();
      state = AsyncValue.data(staffArray);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
