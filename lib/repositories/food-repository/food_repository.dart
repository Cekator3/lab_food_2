import 'package:lab_food_2/repositories/food-repository/DTO/food.dart';
import 'package:lab_food_2/repositories/food-repository/DTO/food_list_item.dart';

/// A subsystem for interaction with stored data on foods.
class FoodRepository
{
  /// Retrieves food's details.
  ///
  /// Returns [null] if error was encountered.
  Food? get(int id)
  {
    // ...
  }

  /// Retrieves a list of foods matching the query.
  ///
  /// Returns empty list if error was encountered.
  List<FoodListItem> find(String query)
  {
    // ....
  }
}
