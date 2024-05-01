import 'package:flutter/material.dart';
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
    FoodRepository foods = FoodRepository();
    FoodRepositoryGetErrors errors = FoodRepositoryGetErrors();
    Food? food = await foods.get("food_adc1nzdb5zh4wya5q99krac7k8q6", errors);
    runApp(app);
}
