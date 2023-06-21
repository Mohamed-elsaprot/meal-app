import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:meal_app/provider/meal_prov.dart';
import 'package:meal_app/provider/theme_prov.dart';
import 'package:meal_app/screens/pageview_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meal_screan.dart';
import './screens/filters_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
       WidgetsFlutterBinding.ensureInitialized();
       SharedPreferences prefs= await SharedPreferences.getInstance();
       Widget screen1 = (prefs.getBool('watched')?? false) ? TabsScreen():PageviewScreen();
       //prefs.clear();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create:(ctx)=> MealProvider(),
      ),
      ChangeNotifierProvider(
        create:(ctx)=> ThemeProv(),
      ),
      ChangeNotifierProvider(
        create:(ctx)=> LanguageProvider(),
      ),
    ],child: MyApp(screen1),)
  );
}

class MyApp extends StatelessWidget {

  final Widget screen1;
  MyApp(this.screen1);

  @override
  Widget build(BuildContext context) {
    var pr=Provider.of<ThemeProv>(context,listen: true).primaryColor;
    var ac=Provider.of<ThemeProv>(context,listen: true).accentColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: Provider.of<ThemeProv>(context).th,
      theme: ThemeData(
        primarySwatch: pr,
        accentColor: ac,
        canvasColor: Color.fromRGBO(255, 255, 230, 1),// lon 5alfyet el body fel application kolo
        buttonColor: Colors.black87,
        shadowColor:Colors.black54,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: pr,
          centerTitle: true
        ),
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(color: Colors.black87,fontSize:40,fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: Colors.black,fontSize: 17,),
            subtitle1: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black87),),
      ),
      darkTheme: ThemeData(
        primaryColor: Color.fromRGBO(20, 20, 70, 1),
        accentColor:Colors.black87,
        canvasColor: Color.fromRGBO(14, 22, 40, 1),
        //fontFamily: '',
        buttonColor: Colors.white54,
        unselectedWidgetColor: Colors.white54,  //lon radio button inactive
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(20, 20, 50, 1),
          centerTitle: true
          ),
        cardColor: Color.fromRGBO(35, 35, 40, 1),
        shadowColor: Colors.black54,
        iconTheme: IconThemeData(
              color: Colors.white
          ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          headline1: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.white,fontSize: 17),
          subtitle1: TextStyle(color: Colors.white60,fontSize: 20,fontWeight: FontWeight.bold)
        )
      ),
      routes: {
        '/': (context) => PageviewScreen(),
        TabsScreen.routName:(context)=> TabsScreen(),
        CategoryMealScrean.routName: (context) => CategoryMealScrean(),
        MealDetailsScreen.routName: (context) => MealDetailsScreen(),
        FiltersScreen.routName: (context) => FiltersScreen(),
        ThemeScreen.routName: (context)=> ThemeScreen(),
      },
      // home: CategoriesScreen(),
      //  home: MyHomePage(),
    );
  }
}
