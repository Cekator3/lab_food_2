// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/DTO/favorite_food_list_item.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/errors/favorite_food_repository_get_all_errors.dart';
import 'package:lab_food_2/repositories/favorite-food-repository/favorite_food_repository.dart';

import '../food_details_page/food_details_page.dart';

class FavoriteFoodsPage extends StatefulWidget
{
  const FavoriteFoodsPage({super.key});

  @override
  FavoriteFoodsPageState createState() => FavoriteFoodsPageState();
}

class FavoriteFoodsPageState extends State<FavoriteFoodsPage>
{
  List<FavoriteFoodListItem>? _foodList;

  void showErrorMessage(String message)
  {
      final snackBar = SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _updateFoodList() async
  {
      final foods = FavoriteFoodRepository();
      final errors = FavoriteFoodRepositoryGetAllErrors();

      await foods.init();
      final foodList = await foods.getAll(errors);
      if (errors.hasAny())
      {
        if (errors.isInternetConnectionMissing())
          showErrorMessage('Отсутствует интернет-соединение');
        if (errors.isInternalErrorOccurred())
          showErrorMessage('В приложении произошла критическая ошибка. Разработчики уже были оповещены.');

        return;
      }
      setState(() {
        _foodList = foodList;
      });
  }

  @override
  void initState()
  {
    super.initState();
    _updateFoodList();
  }


  SizedBox _getFoodThumbnail(FavoriteFoodListItem food)
  {
    return SizedBox(
      width: 50.0,
      height: 50.0,
      child: food.getThumbnail() == null
        ?  const Icon(Icons.image, color: Colors.white)
        :  Image.network(food.getThumbnail()!, fit: BoxFit.cover)
    );
  }

  @override
  Widget build(BuildContext context)
  {
    _updateFoodList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),

      body: Container(
        padding: const EdgeInsets.all(10),
        child: _foodList == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: _foodList!.length,
              itemBuilder: (context, index)
              {
                final food = _foodList![index];

                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: ListTile(
                    title: Text(food.getName()),
                    leading: _getFoodThumbnail(food),
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetailsPage(foodId: food.getId()),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
      )
    );
  }
}
