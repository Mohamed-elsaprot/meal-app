import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:meal_app/provider/meal_prov.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealScrean extends StatefulWidget {
  static const routName = 'category_meal';

  @override
  _CategoryMealScreanState createState() => _CategoryMealScreanState();
}

class _CategoryMealScreanState extends State<CategoryMealScrean> {
  String categoryTitle;
  List displayMeal;

  @override
  void didChangeDependencies() {
    final List avaliableMeal =
        Provider.of<MealProvider>(context).availableMeals;

    final routArg = ModalRoute.of(context).settings.arguments as Map;
    final categoryId = routArg['id'];
    categoryTitle = routArg['title'];
    displayMeal = avaliableMeal.where((element) {
      return element.categories.contains(categoryId);
      //true;
    }).toList();
    super.didChangeDependencies();
  }

  // @override
  // void initSate(){
  //  Future.delayed(Duration.zero).then((value) {
  //    final routArg= ModalRoute.of(context).settings.arguments as Map;
  //    final categoryId= routArg['id'];
  //    final categoryTitle= routArg['title'];
  //    List displayMeal=DUMMY_MEALS.where((element) {
  //      return element.categories.contains(categoryId);
  //    }).toList();
  //
  //
  //  });
  // }

  void removeMeal(String mealId) {
    setState(() {
      displayMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final routArg= ModalRoute.of(context).settings.arguments as Map;
    // final categoryId= routArg['id'];
    // final categoryTitle= routArg['title'];
    // List categoryMeal=DUMMY_MEALS.where((element) {
    //   return element.categories.contains(categoryId);
    // }).toList();
    bool isLandscape= MediaQuery.of(context).orientation == Orientation.landscape;
    var size=MediaQuery.of(context).size;
    var lan=Provider.of<LanguageProvider>(context);

    final routArg = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(lan.getTexts('cat-${routArg['id']}')),
        //backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: isLandscape?size.width/2 : size.width,
            childAspectRatio:isLandscape?1.3/1.1 : 5/4.2,
            // crossAxisSpacing: 10,
            // mainAxisSpacing: 10,
          ),
        itemBuilder: (BuildContext context, int index) {
          return MealItem(
            imageUrl: displayMeal[index].imageUrl,
            title: displayMeal[index].title,
            duration: displayMeal[index].duration,
            complexity: displayMeal[index].complexity,
            affordability: displayMeal[index].affordability,
            id: displayMeal[index].id,
            // removeItem: removeMeal ,
          );
        },
        itemCount: displayMeal.length,
      ),
    );
  }
}
