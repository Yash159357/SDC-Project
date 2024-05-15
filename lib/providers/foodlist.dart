import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/data/dummyData.dart';
import 'package:project/model/food.dart';


class foodListNotifier extends StateNotifier<List<Food>> {
  foodListNotifier() : super(foodList);

}

final foodListProvider =
    StateNotifierProvider<foodListNotifier, List<Food>>((ref) {
  return foodListNotifier();
});