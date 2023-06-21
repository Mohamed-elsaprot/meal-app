import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:meal_app/provider/theme_prov.dart';
import '../widgets/my_drawer.dart';
import '../screens/favorites_screen.dart';
import '../screens/categories_screen.dart';
import 'package:provider/provider.dart';
import '../provider/meal_prov.dart';

class TabsScreen extends StatefulWidget {
  final bool onPageview;
  static String routName = 'tabs_screen';

  TabsScreen({this.onPageview = false});

  @override
  _TabsScreenState createState() => _TabsScreenState();
  }


class _TabsScreenState extends State<TabsScreen> {
  List pages;

  initState() {
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemeProv>(context, listen: false).getThemeMode();
    Provider.of<ThemeProv>(context, listen: false).getColors();
    Provider.of<LanguageProvider>(context, listen: false).getLan();

    pages = [
      {
        'title': 'categories',
        'page': CategoriesScreen()
      },
      {
        'title': 'your_favorites',
        'page': FavoritesScreen()
      }
    ];
    super.initState();
  }


  int selectedPageIndex = 0;

  void selectedPage(int x) {
    setState(() {
      selectedPageIndex = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool onPageview = widget.onPageview;

    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts(pages[selectedPageIndex]['title'])),
          //backgroundColor: Theme.of(context).primaryColor,
        ),
        body: pages[selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          onTap: selectedPage,
          currentIndex: selectedPageIndex,
          selectedFontSize: 20,
          unselectedFontSize: 14,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black54,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: lan.getTexts('categories'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: lan.getTexts('your_favorites'),
            )
          ],
        ),
        drawerScrimColor: Colors.black12,
        drawer: MyDrawer() ,
        //endDrawer: lan.isEn ?null: MyDrawer(),
      ),
    );
  }
}

