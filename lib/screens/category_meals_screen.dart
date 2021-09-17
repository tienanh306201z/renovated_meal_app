import 'package:flutter/material.dart';
import '../data.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';
  List<Meal> _availableMeals = [];

  CategoryMealsScreen(this._availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = '';
  List<Meal> categoryMeals = [];
  var _isFullyLoaded = false;

  void _removeMeal(String mealID) {
    setState(() {
      categoryMeals.removeWhere((element) => element.id == mealID);
      MEALS_DATA.removeWhere((element) => element.id == mealID);
    });
  }

  @override
  void didChangeDependencies() {
    if (!_isFullyLoaded) {
      final categoryArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryID = categoryArgs['id'] as String;
      categoryTitle = categoryArgs['title'] as String;
      categoryMeals = widget._availableMeals
          .where((meal) => meal.categories.contains(categoryID))
          .toList();
      _isFullyLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: categoryMeals.isEmpty
            ? Center(
                child: Text('No meals of this category'),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) => MealItem(
                  id: categoryMeals[index].id,
                  title: categoryMeals[index].title,
                  imageUrl: categoryMeals[index].imageUrl,
                  duration: categoryMeals[index].duration,
                  complexity: categoryMeals[index].complexity,
                  affordability: categoryMeals[index].affordability,
                  removeMeal: _removeMeal,
                  isfavoriteTab: false,
                ),
                itemCount: categoryMeals.length,
              ));
  }
}
