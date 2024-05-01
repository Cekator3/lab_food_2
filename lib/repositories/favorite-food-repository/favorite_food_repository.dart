import 'package:lab_food_2/repositories/favorite-food-repository/DTO/favorite_food_list_item.dart';

/// A subsystem for interaction with stored data on user's favourite foods.
class FavoriteFoodRepository
{
  /// Retrieves a list of user's favourite foods.
  ///
  /// Returns empty list if error was encountered.
  List<FavoriteFoodListItem> getAll()
  {
    // ...
  }

  /// Adds a food to the user's list of favorite foods.
  void add(int foodId)
  {
    // ...
  }

  /// Removes a food from the user's list of favorite foods.
  void remove(int foodId)
  {
    // ...
  }

  /// Checks if a food is in the user's list of favorite foods.
  bool contains(int foodId)
  {
    // ...
  }
}
