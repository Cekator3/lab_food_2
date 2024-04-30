import 'package:flutter/material.dart';

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

void main()
{
    WeatherApp app = const WeatherApp();
    runApp(app);
}
