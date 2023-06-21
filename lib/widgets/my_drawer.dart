import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';

import '../screens/tabs_screen.dart';

class MyDrawer extends StatelessWidget {


  Widget buildTile(String title,IconData icon,Function f,BuildContext ctx){
    return ListTile(
      title: Text(title,style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Theme.of(ctx).textTheme.subtitle1.color
      ),
      ),
      leading: Icon(icon,size: 26,color: Theme.of(ctx).textTheme.subtitle1.color,),
      trailing: Icon(Icons.arrow_forward_ios ,size: 20,color: Theme.of(ctx).textTheme.subtitle1.color,),
      onTap: f,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan= Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr: TextDirection.rtl,
      child: Drawer(
        elevation: 50,
        child: ListView(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(20),
              child: Text(lan.getTexts('drawer_name'),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.white
              ),
              ),
            ),
            SizedBox(height: 20,),
            buildTile(lan.getTexts('drawer_item1'),Icons.restaurant,(){
              Navigator.of(context).pushReplacementNamed(TabsScreen.routName);
            },context),
            SizedBox(height: 5,),
            buildTile(lan.getTexts('drawer_item2'),Icons.settings,(){
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routName);
            },context),
            buildTile(lan.getTexts('drawer_item3'),Icons.color_lens,(){
              Navigator.of(context).pushReplacementNamed(ThemeScreen.routName);
            },context),
            Divider(thickness: 1,color: Colors.black,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  lan.getTexts('drawer_switch_item2'),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Switch(
                    inactiveTrackColor: Colors.black12,
                    activeColor: Theme.of(context).buttonColor,
                    value: lan.isEn,
                    onChanged: (newVal){
                      Provider.of<LanguageProvider>(context,listen: false).changeLan(newVal);
                      Navigator.of(context).pop();
                    }
                ),
                Text(
                    lan.getTexts('drawer_switch_item1'),
                    style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            Divider(thickness: 1,color: Colors.black54,),


          ],
        ),
      ),
    );
  }
}
