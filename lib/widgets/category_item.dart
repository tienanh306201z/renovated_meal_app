import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';
import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
        arguments: {'id': category.id, 'title': category.title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      child: LayoutBuilder(
        builder: (context, constraint) => Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [category.color, Colors.orange.shade100],
                      begin: Alignment.centerLeft,
                      end: Alignment.topRight),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                        color: Color(0xFF000000),
                        offset: Offset(2, 2),
                        blurRadius: 3)
                  ]),
            ),
            Container(
              width: constraint.maxHeight,
              height: constraint.maxHeight,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(colors: [
                    category.color,
                    Colors.orange.shade200,
                  ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              height: constraint.maxHeight,
              width: constraint.maxWidth,
              child: Text(
                category.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
