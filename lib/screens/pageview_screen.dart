import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PageviewScreen extends StatefulWidget {
  @override
  State<PageviewScreen> createState() => _PageviewScreenState();
}

class _PageviewScreenState extends State<PageviewScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var lan = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Theme.of(context).shadowColor,
                      padding: EdgeInsets.all(8),
                      width: 300,
                      alignment: Alignment.center,
                      // طريقه 1 من container
                      child: Text(lan.getTexts('drawer_name'),
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 300,
                      color: Theme.of(context).shadowColor,
                      child: Column(children: [
                        Text(
                          lan.getTexts('drawer_switch_title'),
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(lan.getTexts('drawer_switch_item2'),
                                style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)
                            ),
                            Switch(
                              value: lan.isEn,
                              onChanged: (newValue) {
                                Provider.of<LanguageProvider>(context,
                                        listen: false)
                                    .changeLan(newValue);
                              },
                            ),
                            Text(lan.getTexts('drawer_switch_item1'),
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              FiltersScreen(
                onPageview: true,
              ),
              ThemeScreen(
                onPageview: true,
              )
            ],
            onPageChanged: (newVal) {
              setState(() {
                index = newVal;
              });
            },
          ),
          Indecator(index),
          Builder(
            builder: (ctx) => Align(
              alignment: Alignment(0, 0.85),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: MaterialButton(
                  padding: lan.isEn ? EdgeInsets.all(7) : EdgeInsets.all(0),
                  color: primaryColor,
                  child: Text(lan.getTexts('start'),
                      style: TextStyle(
                          color: useWhiteForeground(primaryColor)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25)),
                  onPressed: () async {
                    Navigator.of(ctx).pushReplacementNamed(TabsScreen.routName);
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('watched', true);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Indecator extends StatelessWidget {
  final int index;

  Indecator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(
            Icons.ac_unit,
            color: Theme.of(ctx).buttonColor,
          )
        : Container(
            margin: EdgeInsets.all(5),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(ctx).accentColor),
          );
  }
}
