import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal_prov.dart';
import '../widgets/category_item.dart';
import 'package:provider/provider.dart';
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('cat secreen');
    return Scaffold(
      body: GridView(
          padding: EdgeInsets.all(15),
          children: [
            ...( Provider.of<MealProvider>(context).availableCategory.map((e) {
              return CategoryItem(e.id, e.title, e.color);
            }))
          ],
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2.1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          )),
    );
  }
}
