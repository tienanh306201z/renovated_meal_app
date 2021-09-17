import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  List<Meal> favoriteList;

  FavoritesScreen(this.favoriteList);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void _removeMeal(String mealID) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.favoriteList.isEmpty
            ? Center(
                child: Text('Empty Favorite List'),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) => MealItem(
                  id: widget.favoriteList[index].id,
                  title: widget.favoriteList[index].title,
                  imageUrl: widget.favoriteList[index].imageUrl,
                  duration: widget.favoriteList[index].duration,
                  complexity: widget.favoriteList[index].complexity,
                  affordability: widget.favoriteList[index].affordability,
                  removeMeal: _removeMeal,
                  isfavoriteTab: true,
                ),
                itemCount: widget.favoriteList.length,
              ));
  }
}
