import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import '../dummy_data.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/provider/meal_prov.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routName = 'meal_detail';
  
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((m) => m.id == mealId);
    var lan =Provider.of<LanguageProvider>(context);
    bool landscape=MediaQuery.of(context).orientation ==Orientation.landscape;
    Size size =MediaQuery.of(context).size;

    Widget buildContainer(Widget child) {

      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 5)),
        width:landscape? (size.width/2)-30: null,
        height:landscape? size.height/2.1: size.height/4.5,
         padding: EdgeInsets.all(10),
         margin: EdgeInsets.all(15),
        child: child,
      );
    }
    Widget buildTitle(BuildContext c, String s) {
      return Container(
        //margin: EdgeInsets.all(18),
        padding: EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        child: Text(s, style: Theme.of(c).textTheme.subtitle1),
      );
    }
    List ingredients=lan.getTexts('ingredients-$mealId');
    List stepsText=lan.getTexts('steps-$mealId');

    var ingredient=ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Card(
        color:Theme.of(context).accentColor,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(ingredients[index]),
        ),
      ),
      itemCount: selectedMeal.ingredients.length,
    );
    var steps=ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${index + 1}'),
            ),
            title: Text(
              stepsText[index],
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 5,
            thickness: 2,
          )
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );
    return Scaffold(
      body:CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            //centerTitle: true,
            title:lan.isEn?null:
            Container(
                child: Text('${lan.getTexts('meal-${selectedMeal.id}')}',
                  style: TextStyle(fontWeight: FontWeight.w700,color: Colors.red),
                ),
                padding: EdgeInsets.symmetric(vertical:4,horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
                ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title:
              lan.isEn?
              Container(
                padding: EdgeInsets.symmetric(vertical:4,horizontal: 10),
                child: Text('${lan.getTexts('meal-${selectedMeal.id}')}',),
                decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor.withOpacity(.35),
                  borderRadius: BorderRadius.circular(5)
                ),
              ) :null,
              background: Hero(
                tag: mealId,
                child: InteractiveViewer(
                  child:FadeInImage(
                    placeholder: AssetImage('assets/images/image.jpg'),
                    image:NetworkImage(selectedMeal.imageUrl),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          SliverList(delegate:SliverChildListDelegate([
            // Container(
            //   margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       border: Border.all(color: Colors.grey, width: 5)),
            //   width:landscape? size.width/1.3: size.width,
            //   // height: 230,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child:
            //   ),
            // ),
            SizedBox(height: 6,child: Divider(thickness: 6,color: Colors.black,),),
            if(landscape)Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    buildTitle(context, lan.getTexts('Ingredients')),
                    buildContainer(ingredient),
                  ],
                ),
                Column(
                  children: [
                    buildTitle(context, lan.getTexts('Steps')),
                    buildContainer(steps),
                  ],
                )
              ],
            ),
            if(!landscape)buildTitle(context, lan.getTexts('Ingredients')),
            if(!landscape)buildContainer(ingredient),
            if(!landscape)buildTitle(context, lan.getTexts('Steps')),
            if(!landscape)buildContainer(steps),
            SizedBox(height: 450,)
          ],), ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        //backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
        child: Icon(
          Provider.of<MealProvider>(context).isMealFavorite(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
      ),
    );
  }
}
