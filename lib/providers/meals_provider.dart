import 'package:flutter_meals_app/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 這種作法在靜態資料時很好用，但是在動態資料時就不太適合了
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
