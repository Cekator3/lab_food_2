import 'package:flutter/material.dart';
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
  List<FoodListItem> _foodList = [];

  void _performSearch() async
  {
    final foods = FoodRepository();
    final errors = FoodRepositoryFindErrors();

    final foodList = await foods.find(_searchQuery, errors);

    // TODO errors handling

    setState(() {
      _foodList = foodList;
    });

    Navigator.pop(context);
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
              onPressed: _performSearch,
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

  SizedBox _getFoodThumbnail(FoodListItem food)
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0)
          ),
          padding: const EdgeInsets.all(16.0),
          child: _foodList.isEmpty
              ? const Center(child: Text('Начните поиск'))
              : ListView.builder(
                  itemCount: _foodList.length,
                  itemBuilder: (context, index)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        title: Text(_foodList[index].getName()),
                        leading: _getFoodThumbnail(_foodList[index])
                        // onTap: ()
                        // {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ProductDetailScreen(foodId: _foodList[index].getId()),
                        //     ),
                        //   );
                        // },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
