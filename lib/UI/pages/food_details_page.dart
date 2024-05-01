// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/favorite_food_repository.dart';
import 'package:lab_food_2/repositories/food-repository/errors/food_repository_get_errors.dart';
import 'package:lab_food_2/repositories/food-repository/food_repository.dart';

import '../../repositories/food-repository/DTO/food.dart';

class FoodDetailsPage extends StatefulWidget
{
  final String foodId;

  const FoodDetailsPage({super.key, required this.foodId});

  @override
  FoodDetailsPageState createState() => FoodDetailsPageState();
}

class FoodDetailsPageState extends State<FoodDetailsPage>
{
  Food? _food;
  late FavoriteFoodRepository _favoriteFoods;
  bool _isFoodFavorite = false;

  Future<void> _initFoodDetails() async
  {
    final foods = FoodRepository();
    final errors = FoodRepositoryGetErrors();

    final food = await foods.get(widget.foodId, errors);
    setState(() {
      _food = food;
    });

    // TODO errors handling
  }

  /// Reverses food's "favorite" status.
  ///
  /// If food is in the "favorite" list then it will be removed from it.
  /// Otherwise it will be added to it.
  void _toggleFoodFavoriteStatus()
  {
    if (_isFoodFavorite)
      _favoriteFoods.remove(widget.foodId);
    else
      _favoriteFoods.add(widget.foodId);

    setState(() {
      _isFoodFavorite = ! _isFoodFavorite;
    });
  }

  @override
  void initState()
  {
    super.initState();
    _initFoodDetails();

    () async {
      final favoriteFoods = FavoriteFoodRepository();
      await favoriteFoods.init();
      setState(() {
        _favoriteFoods = favoriteFoods;
        _isFoodFavorite = _favoriteFoods.contains(widget.foodId);
      });
    }();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(_food?.getName() ?? ''),
        actions: [
          IconButton(
            icon: Icon(
              _isFoodFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFoodFavorite ? Colors.amber : Colors.black,
            ),
            onPressed: _toggleFoodFavoriteStatus,
          )
        ],
      ),

      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.all(16.0),

              child: _food == null
               ? const Center(child: CircularProgressIndicator())
               : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImageWithRetry(
                            _food!.getThumbnail() ?? 'https://via.placeholder.com/150',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Категория: ${_food!.getCategory()}'),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Энергетическая ценность: ${_food!.getNutrient().getEnergyInKcal()} ккал.'),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Белки: ${_food!.getNutrient().getProteinInGram()} г.'),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Жиры: ${_food!.getNutrient().getFatInGram()} г.'),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Углеводы: ${_food!.getNutrient().getCarbohydrateInGram()} г.'),
                        ),
                      ],
                    )
                  ],
                ),
               )
            ),
          )
        ],
      ),
    );
  }
}
