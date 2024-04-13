import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final isExisting = state.contains(meal);

    if (isExisting) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// 在動態資料時，我們可以使用 StateProvider 來提供資料
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
