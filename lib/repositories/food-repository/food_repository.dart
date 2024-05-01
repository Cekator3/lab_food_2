import 'package:lab_food_2/repositories/food-repository/DTO/food.dart';
import 'package:lab_food_2/repositories/food-repository/DTO/food_list_item.dart';
import 'package:lab_food_2/repositories/food-repository/errors/food_repository_find_errors.dart';
import 'package:lab_food_2/repositories/food-repository/errors/food_repository_get_errors.dart';

/// A subsystem for interaction with stored data on foods.
class FoodRepository
{
  /// Retrieves food's details.
  ///
  /// Returns [null] if error was encountered.
  Food? get(int id, FoodRepositoryGetErrors errors)
  {
    // ...
  }

  /// Retrieves a list of foods matching the query.
  ///
  /// Returns empty list if error was encountered.
  List<FoodListItem> find(String query, FoodRepositoryFindErrors errors)
  {
    // ....
  }
}
