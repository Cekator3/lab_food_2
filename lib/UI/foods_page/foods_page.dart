// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_food_2/UI/foods_page/widgets/food_list.dart';
import '../../repositories/food-repository/DTO/food_list_item.dart';
import '../../repositories/food-repository/errors/food_repository_find_errors.dart';
import '../../repositories/food-repository/food_repository.dart';

class FoodsPage extends StatefulWidget
{
  const FoodsPage({super.key});

  @override
  FoodsPageState createState() => FoodsPageState();
}

class FoodsPageState extends State<FoodsPage>
{
  String _searchQuery = '';
  List<FoodListItem>? _foodList = [];

  void showErrorMessage(String message)
  {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _performSearch() async
  {
    final foods = FoodRepository();
    final errors = FoodRepositoryFindErrors();

    setState(() {
      _foodList = null;
    });
    final foodList = await foods.find(_searchQuery, errors);

    if (errors.hasAny())
    {
      setState(() {
        _foodList = [];
        _searchQuery = '';
      });

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

  void _showSearchDialog() async
  {
    var query = await showDialog<String>(
      context: context,
      builder: (context)
      {
        return AlertDialog(
          title: const Text('Поиск'),
          content: TextField(
            onChanged: (value)
            {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: const InputDecoration(hintText: 'Поиск...'),
          ),
          actions: [
            TextButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: ()
              {
                _performSearch();
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    if (query != null) {
      setState(() {
        _searchQuery = query;
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Еда'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          )
        ],
      ),
      body:
      _foodList == null
        ? const Center(child: CircularProgressIndicator())
        : FoodListWidget(foodList: _foodList,)
    );
  }
}
