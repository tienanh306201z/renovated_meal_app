import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import './data.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> favoriteList = [];

  void _setFavoriteMeal(String mealID) {
    final meal = MEALS_DATA.firstWhere((element) => element.id == mealID);
    if (!favoriteList.contains(meal)) favoriteList.add(meal);
  }

  void _removeFavoriteMeal(String mealID) {
    final meal = MEALS_DATA.firstWhere((element) => element.id == mealID);
    if (favoriteList.contains(meal)) favoriteList.remove(meal);
  }

  final themeList = {
    'Bright': {
      'primaryColor': Colors.red,
      'accentColor': Colors.amber,
      'canvas': Color.fromRGBO(255, 254, 229, 1),
      'textTheme': ThemeData.light().textTheme
    },
    'Dark': {
      'primaryColor': Colors.indigo,
      'accentColor': Colors.blue,
      'canvas': Color(0xFF0C063D),
      'textTheme': ThemeData.dark().textTheme
    }
  };

  String _theme = 'Bright';

  void _setTheme(String theme) {
    setState(() {
      _theme = theme;
    });
  }

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = MEALS_DATA;

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = MEALS_DATA.where((element) {
        if ((_filters['gluten'] as bool) && !element.isGlutenFree) return false;
        if ((_filters['lactose'] as bool) && !element.isLactoseFree)
          return false;
        if ((_filters['vegan'] as bool) && !element.isVegan) return false;
        if ((_filters['vegetarian'] as bool) && !element.isVegetarian)
          return false;
        return true;
      }).toList();
      print(_filters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
          primarySwatch: themeList[_theme]!['primaryColor'] as MaterialColor,
          accentColor: themeList[_theme]!['accentColor'] as MaterialColor,
          colorScheme: ColorScheme.light(
            secondary: themeList[_theme]!['accentColor'] as MaterialColor,
            primary: themeList[_theme]!['primaryColor'] as MaterialColor,
          ),
          canvasColor: themeList[_theme]!['canvas'] as Color,
          fontFamily: 'Raleway',
          textTheme: (themeList[_theme]!['textTheme'] as TextTheme).copyWith(
            headline6: TextStyle(
                color: _theme.compareTo('Bright') == 0
                    ? Colors.black
                    : Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          )),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.food_bank_outlined,
                size: 40,
                color: Colors.deepOrangeAccent,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  'Meal App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 254, 229, 1),
        nextScreen: TabsScreen(favoriteList),
        splashTransition: SplashTransition.fadeTransition,
      ),
      routes: {
        '/tab-screen': (ctx) => TabsScreen(favoriteList),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            _theme, _setFavoriteMeal, _removeFavoriteMeal, favoriteList),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
            setFilter: _setFilter,
            currentFilter: _filters,
            setTheme: _setTheme,
            currentTheme: _theme),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
