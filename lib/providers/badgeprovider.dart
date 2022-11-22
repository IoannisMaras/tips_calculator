import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/badgevaluemodel.dart';

final badgeValueProvider =
    StateNotifierProvider<BadgeValueNotifier, List<BadgeValueModel>>((ref) {
  return BadgeValueNotifier();
});

class BadgeValueNotifier extends StateNotifier<List<BadgeValueModel>> {
  // We initialize the list of todos to an empty list
  BadgeValueNotifier() : super([]);

  void addTodo(BadgeValueModel todo) {
    state = [...state, todo];
  }

  // Let's allow removing todos
  void removeTodo(String todoId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Let's mark a todo as completed

}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.

