import 'package:lab_food_2/repositories/favorite-food-repository/DTO/favorite_food_list_item.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/errors/favorite_food_repository_get_all_errors.dart';

/// A subsystem for interaction with stored data on user's favourite foods.
class FavoriteFoodRepository
{
  /// Retrieves a list of user's favourite foods.
  ///
  /// Returns empty list if error was encountered.
  List<FavoriteFoodListItem> getAll(FavoriteFoodRepositoryGetAllErrors errors)
  {
    // ...
  }

  /// Adds a food to the user's list of favorite foods.
  ///
  /// If food is already in the list nothing will happen.
  void add(String foodId)
  {
    // ...
  }

  /// Removes a food from the user's list of favorite foods.
  ///
  /// If food not in the list nothing will happen.
  void remove(String foodId)
  {
    // ...
  }

  /// Checks if a food is in the user's list of favorite foods.
  bool contains(String foodId)
  {
    // ...
  }
}
