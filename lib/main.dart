import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_food_2/UI/favorite_foods_page/favorite_foods_page.dart';
import 'package:lab_food_2/UI/foods_page/foods_page.dart';

class FoodApp extends StatefulWidget
{
  const FoodApp({super.key});

  @override
  FoodAppState createState() => FoodAppState();
}

class FoodAppState extends State<FoodApp>
{
  int currentIndex = 0;

  @override
  Widget build(BuildContext context)
  {
    void onNavigationBarLinkTapped(int index) async
    {
      setState(() {
        currentIndex = index;
      });
    }

    return MaterialApp(
        title: 'Еда',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
                onSurface: Colors.cyan,
                onBackground: Colors.cyan,
            ),
            textTheme: GoogleFonts.manropeTextTheme(),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.cyan,
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                ),
                centerTitle: true,
            ),
        ),
        home: Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: const [
              FoodsPage(),
              FavoriteFoodsPage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onNavigationBarLinkTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Избранное',
              ),
            ],
          ),
        )
    );
  }
}

void main() async
{
    FoodApp app = const FoodApp();
    runApp(app);
}
