import 'package:flutter/material.dart';
import '../widgets/category_item.dart';

import '../data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      children: CATEGORIES_DATA.map((e) => CategoryItem(e)).toList(),
    );
  }
}
