import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/staffmodel.dart';

final badgeValueProvider =
    StateNotifierProvider<BadgeValueNotifier, Map<int, int>>((ref) {
  return BadgeValueNotifier();
});

class BadgeValueNotifier extends StateNotifier<Map<int, int>> {
  // We initialize the list of todos to an empty list
  BadgeValueNotifier() : super({});

  void initList(List<StaffModel> staffArray) {
    Map<int, int> tempBadgeValues = {};
    for (final staff in staffArray) {
      tempBadgeValues[staff.id as int] = 0;
      //tempBadgeValues.add(BadgeValueModel(staff.id as int, 0));
    }
    state = {...tempBadgeValues};
  }

  void incValue(int id) {
    Map<int, int> temp = {id: (state[id] as int) + 1};
    state = {...state, ...temp};
  }

  void decValue(int id) {
    int newStateValue = (state[id] as int) > 0 ? (state[id] as int) - 1 : 0;
    Map<int, int> temp = {id: newStateValue};
    state = {...state, ...temp};
  }

  void addBadge(StaffModel staff) {
    Map<int, int> temp = {staff.id as int: 0};
    state = {...state, ...temp};
  }

  // Let's allow removing todos
  void removeBadge(int badgeId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    Map<int, int> temp = state;

    temp.remove(badgeId);

    state = {...temp};
  }

  void clearAllBadges() {
    Map<int, int> temp = state;
    temp.forEach((key, value) {
      temp[key] = 0;
    });

    state = {...temp};
  }

  // Let's mark a todo as completed

}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.

