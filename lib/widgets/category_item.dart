import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:provider/provider.dart';
import '../provider/meal_prov.dart';
import '../screens/category_meal_screan.dart';

class CategoryItem extends StatelessWidget {

  var id;
  var title;
  var color;

  CategoryItem(this.id,this.title,this.color);

  void selectCategory(BuildContext context){
    Navigator.of(context).pushNamed(
        CategoryMealScrean.routName,
            arguments: {
          'id':id,
          'title':title,
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    var lan= Provider.of<LanguageProvider>(context,listen: true);
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: (){
        selectCategory(context);
        Provider.of<MealProvider>(context,listen: false).setfillter();
      } ,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(lan.getTexts('cat-$id'),style: Theme.of(context).textTheme.subtitle1,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(.7),
              color.withOpacity(.3)
            ],
            begin: Alignment.topLeft ,
            end: Alignment.bottomRight
          )
        ),
      ),
    );
  }
}
