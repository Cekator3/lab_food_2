// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'DTO/food.dart';
import 'DTO/food_list_item.dart';
import 'package:http/http.dart' as http;
import 'errors/food_repository_find_errors.dart';
import 'errors/food_repository_get_errors.dart';
import 'package:lab_food_2/repositories/food-repository/DTO/nutrient.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


/// A subsystem for interaction with stored data on foods.
class FoodRepository
{
  static const String _APP_ID = 'b8e1c762';
  static const String _APP_KEY = 'b0b1379f2ba58396198214cc4f9c476c';

  /// Checks if device is connected to the internet
  Future<bool> _isConnectedToInternet() async
  {
      return await InternetConnection().hasInternetAccess;
  }

  /// Retrieves food's details from API server
  Future<Food?> _getFromAPI(String foodId, FoodRepositoryGetErrors errors) async
  {
    final response = await http.get(
      Uri.parse(
          'https://api.edamam.com/api/food-database/v2/parser?ingr=${Uri.encodeComponent(foodId)}&app_id=$_APP_ID&app_key=$_APP_KEY'),
    );

    if (response.statusCode != 200)
    {
      errors.add(FoodRepositoryGetErrors.INTERNAL);
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

  Nutrient _convertToNutrient(dynamic nutrientFromApi)
  {
    return Nutrient(

    );
  }

  /// Convert API's food list item to app's food list item
  Food _convertToFood(dynamic foodFromApi)
  {
    return Food(
      id: foodFromApi['foodId'],
      name: foodFromApi['label'],
      thumbnailUrl: foodFromApi['image'],
      nutrients: foodFromApi['nutrients'],
      category: foodFromApi['category']
    );
  }

  /// Retrieves food's details.
  ///
  /// Returns [null] if error was encountered.
  Future<Food?> get(String id, FoodRepositoryGetErrors errors) async
  {
    if (! (await _isConnectedToInternet()))
    {
      errors.add(FoodRepositoryGetErrors.INTERNET_CONNECTION_MISSING);
      return null;
    }

    final foodFromApi = await _getFromAPI(id, errors);
    return null;
  }



  /// Retrieves a list of foods from API server
  Future<List> _findFromAPI(String query, FoodRepositoryFindErrors errors) async
  {
    final response = await http.get(
      Uri.parse(
          'https://api.edamam.com/api/food-database/v2/parser?ingr=$query&app_id=$_APP_ID&app_key=$_APP_KEY'),
    );

    if (response.statusCode == 200)
        return jsonDecode(response.body)['hints'];

    errors.add(FoodRepositoryFindErrors.INTERNAL);
    return [];
  }

  /// Convert API's food list item to app's food list item
  FoodListItem _convertToFoodListItem(dynamic foodListItemFromApi)
  {
    String id = foodListItemFromApi['food']['foodId'];
    String name = foodListItemFromApi['food']['label'];
    String? thumbnailUrl = foodListItemFromApi['food']['image'];
    return FoodListItem(id, name, thumbnailUrl);
  }

  /// Retrieves a list of foods matching the query.
  ///
  /// Returns empty list if error was encountered.
  Future<List<FoodListItem>> find(String query, FoodRepositoryFindErrors errors) async
  {
    if (! (await _isConnectedToInternet()))
    {
      errors.add(FoodRepositoryFindErrors.INTERNET_CONNECTION_MISSING);
      return [];
    }

    List<FoodListItem> result = [];
    final foodListFromApi = await _findFromAPI(query, errors);
    for (final item in foodListFromApi)
      result.add(_convertToFoodListItem(item));

    return result;
  }
}
