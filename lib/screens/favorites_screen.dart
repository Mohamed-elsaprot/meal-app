import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:meal_app/provider/meal_prov.dart';
import 'package:provider/provider.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final List favoriteMeals =Provider.of<MealProvider>(context).favoritMeals;
    bool isLandscape= MediaQuery.of(context).orientation == Orientation.landscape;
    var size=MediaQuery.of(context).size;
    var lan =Provider.of<LanguageProvider>(context);
    if(favoriteMeals.isEmpty){
      return Center(
        child: Text(lan.getTexts('favorites_text'),style: Theme.of(context).textTheme.bodyText1,),
      );
    }
    else{
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: isLandscape?size.width/2 : size.width,
          childAspectRatio:isLandscape?1.3/1.1 : 5/4.2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return MealItem(
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title ,
            duration: favoriteMeals[index].duration ,
            complexity: favoriteMeals[index].complexity ,
            affordability: favoriteMeals[index].affordability,
            id: favoriteMeals[index].id,

          );
        },
        itemCount: favoriteMeals.length,
      );
    }

  }
}
