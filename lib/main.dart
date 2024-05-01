import 'package:flutter/material.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/errors/favorite_food_repository_get_all_errors.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/favorite_food_repository.dart';
import 'package:lab_food_2/repositories/food-repository/DTO/food_list_item.dart';
import 'package:lab_food_2/repositories/food-repository/errors/food_repository_find_errors.dart';
import 'package:lab_food_2/repositories/food-repository/errors/food_repository_get_errors.dart';
import 'package:lab_food_2/repositories/food-repository/food_repository.dart';

import 'repositories/food-repository/DTO/food.dart';

class WeatherApp extends StatelessWidget
{
    const WeatherApp({super.key});

    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(
            title: 'Прогноз погоды',
            theme: ThemeData(
                useMaterial3: true,
                colorScheme: const ColorScheme.light(
                    onSurface: Colors.cyan,
                    onBackground: Colors.cyan,
                ),
                // textTheme: GoogleFonts.manropeTextTheme(),
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.cyan,
                    titleTextStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                    ),
                    centerTitle: true,
                ),
            ),
            // home: const WeatherHomePage(title: 'Прогноз погоды'),
        );
    }
}

void main() async
{
    WeatherApp app = const WeatherApp();
    runApp(app);
}
