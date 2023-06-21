import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:meal_app/widgets/my_drawer.dart';
import 'package:meal_app/provider/meal_prov.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routName = 'filters';
  final bool onPageview;
  FiltersScreen({this.onPageview=false});

  @override
  _FiltersScreenState createState() => _FiltersScreenState(onPageview);
}

class _FiltersScreenState extends State {
  final onPageview;
  _FiltersScreenState(this.onPageview);

  Widget buildSwitchListTile(String title, String description, bool currentVlue,
      Function updateValue,ctx) {
    return SwitchListTile(
      title: Text(title),
      inactiveTrackColor: Colors.black12,
      activeColor: Theme.of(ctx).buttonColor,
      subtitle: Text(description),
      value: currentVlue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    Map currentFilter = Provider.of<MealProvider>(context).filters;
    var lan= Provider.of<LanguageProvider>(context,listen: true);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          onPageview?SliverAppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
          ):SliverAppBar(
            pinned: false,
            title:Text(lan.getTexts('filters_appBar_title')),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 5,
            
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      lan.getTexts('filters_screen_title'),
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center
                  ),
                ),
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  // lazem 3shan t5aly el ListView el da5lya t3mel scrolling
                  shrinkWrap: true,
                  // mohem law 3awez t7ot listView gowa column
                  children: [
                    buildSwitchListTile(
                        lan.getTexts("Gluten-free"),
                        lan.getTexts('Gluten-free-sub'),
                        currentFilter['gluten'],
                            (newValue) {
                          setState(() {
                            currentFilter['gluten'] = newValue;
                          });
                          Provider.of<MealProvider>(context,listen: false).setfillter();
                        },context),
                    buildSwitchListTile(
                        lan.getTexts('Lactose-free'),
                        lan.getTexts('Lactose-free-sub'),
                        currentFilter['lactose'],
                            (newVal){
                          setState(() {
                            currentFilter['lactose']=newVal;
                          });
                          Provider.of<MealProvider>(context,listen: false).setfillter();
                        },context),
                    buildSwitchListTile(
                        lan.getTexts('Vegetarian'), lan.getTexts('Vegetarian-sub'), currentFilter['vegetarian'],
                            (newValue) {
                          setState(() {
                            currentFilter['vegetarian'] = newValue;
                          });
                          Provider.of<MealProvider>(context,listen: false).setfillter();
                        },context),
                    buildSwitchListTile(lan.getTexts('Vegan'), lan.getTexts('Vegan-sub'), currentFilter['vegan'],
                            (newValue) {
                          setState(() {
                            currentFilter['vegan'] = newValue;
                          });
                          Provider.of<MealProvider>(context,listen: false).setfillter();
                        },context),
                    SizedBox(height: onPageview?70:0,)
                  ],
                ),
              ]
            ),
          )
        ],
      ),
      drawer:onPageview? null:(lan.isEn? MyDrawer():null),
      endDrawer:onPageview?null: (!lan.isEn? MyDrawer():null ),
    );
  }
}

//
/*
Column(
          children: [
            Container(
              child: Text('Adjust your meal selection',style:Theme.of(context).textTheme.subtitle1 ,),
            ),
            ListView(
              children: [
                buildSwitchListTile('Gluten-free', 'only includ gluten-free meals.', glutenFree, (newValue){
                  setState((){
                    glutenFree=newValue;
                  });
                }),
                buildSwitchListTile('Lactos-free', 'only includ lactos-free meals.', lactoseFree, (newValue){
                  setState((){
                    lactoseFree=newValue;
                  });
                }),
                buildSwitchListTile('Vegetarian', 'only includ vegetarian meals.', vegetarian, (newValue){
                  setState((){
                    vegetarian=newValue;
                  });
                }),
                buildSwitchListTile('Vegan', 'only includ vegan meals.', vegan, (newValue){
                  setState((){
                    vegan=newValue;
                  });
                }),

              ],
            ),
          ],
        ),

 */
