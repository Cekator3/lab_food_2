// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/DTO/favorite_food_list_item.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/errors/favorite_food_repository_get_all_errors.dart';

/// A subsystem for interaction with stored data on user's favourite foods.
class FavoriteFoodRepository
{
  static const String _APP_ID = 'b8e1c762';
  static const String _APP_KEY = 'b0b1379f2ba58396198214cc4f9c476c';
  static SharedPreferences? _storage;
  List<String>? _favoriteFoodsIds;

  Future<void> _init() async
  {
    _storage = await SharedPreferences.getInstance();
    _favoriteFoodsIds = _storage!.getStringList('favoriteFoods') ?? [];
  }

  void _updateStorage()
  {
    _storage?.setStringList('favoriteFoods', _favoriteFoodsIds ?? []);
  }

  /// Adds a food to the user's list of favorite foods.
  ///
  /// If food is already in the list nothing will happen.
  Future<void> add(String foodId) async
  {
    if (_favoriteFoodsIds == null)
      await _init();

    if (_favoriteFoodsIds!.contains(foodId))
      return;

    _favoriteFoodsIds!.add(foodId);
    _updateStorage();
  }

  /// Removes a food from the user's list of favorite foods.
  ///
  /// If food not in the list nothing will happen.
  Future<void> remove(String foodId) async
  {
    if (_favoriteFoodsIds == null)
      await _init();

    _favoriteFoodsIds!.remove(foodId);
    _updateStorage();
  }

  /// Checks if a food is in the user's list of favorite foods.
  Future<bool> contains(String foodId) async
  {
    if (_favoriteFoodsIds == null)
      await _init();

    return _favoriteFoodsIds!.contains(foodId);
  }


  /// Checks if device is connected to the internet
  Future<bool> _isConnectedToInternet() async
  {
    return await InternetConnection().hasInternetAccess;
  }

  /// Retrieves food's details from API server
  dynamic _getFoodFromApi(String foodId, FavoriteFoodRepositoryGetAllErrors errors) async
  {
    final response = await http.get(
      Uri.parse(
          'https://api.edamam.com/api/food-database/v2/parser?ingr=${Uri.encodeComponent(foodId)}&app_id=$_APP_ID&app_key=$_APP_KEY'),
    );

    if (response.statusCode != 200)
    {
      errors.add(FavoriteFoodRepositoryGetAllErrors.INTERNAL);
      return null;
    }

    var foodApi = jsonDecode(response.body);
    if (foodApi == null &&
        foodApi['hints'] == null &&
        foodApi['hints'].isEmpty &&
        foodApi['hints'][0]['food'] == null)
    {
      return null;
    }

    return foodApi['hints'][0]['food'];
  }

  /// Converts API's food to app's user favorite food list item
  FavoriteFoodListItem _convertToFavoriteFoodListItem(dynamic foodFromApi)
  {
    String id = foodFromApi['foodId'];
    String name = foodFromApi['label'];
    String? thumbnailUrl = foodFromApi['image'];
    return FavoriteFoodListItem(id, name, thumbnailUrl);
  }

  /// Retrieves a list of user's favourite foods.
  ///
  /// Returns empty list if error was encountered.
  Future<List<FavoriteFoodListItem>> getAll(FavoriteFoodRepositoryGetAllErrors errors) async
  {
    if (_favoriteFoodsIds == null)
      await _init();

    if (! (await _isConnectedToInternet()))
    {
      errors.add(FavoriteFoodRepositoryGetAllErrors.INTERNET_CONNECTION_MISSING);
      return [];
    }

    List<FavoriteFoodListItem> result = [];
    for (String foodId in _favoriteFoodsIds ?? [])
    {
      final foodFromApi = await _getFoodFromApi(foodId, errors);
      if (errors.hasAny())
        return [];
      if (foodFromApi == null)
        continue;

      result.add(_convertToFavoriteFoodListItem(foodFromApi));
    }

    return result;
  }
}
