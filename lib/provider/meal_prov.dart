import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  Map filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List availableMeals = DUMMY_MEALS;
  List<String> favMealId;
  List<Category> availableCategory = DUMMY_CATEGORIES;
  List favoritMeals = [];

  void setfillter() async {
    print('set filter 1');
    availableMeals = DUMMY_MEALS.where((element) {
      if (filters['gluten'] && !element.isGlutenFree) {
        return false;
      }
      if (filters['lactos'] && !element.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !element.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !element.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    // List fm = [];
    // favoritMeals.forEach((fav) {
    //   availableMeals.forEach((av) {
    //     if (fav.id == av.id) fm.add(av);
    //   });
    // });
    // favoritMeals = fm;

    categoryFillter();
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']);
    prefs.setBool('lactos', filters['lactos']);
    prefs.setBool('vegan', filters['vegan']);
    prefs.setBool('vegetarian', filters['vegetarian']);
  }

  void getData() async {
    print('get filter data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = await prefs.getBool('gluten') ?? false;
    filters['lactos'] = await prefs.getBool('lactos') ?? false;
    filters['vegan'] = await prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = await prefs.getBool('vegetarian') ?? false;
    favMealId = prefs.getStringList('favMealId') ?? [];
    setfillter(); // مهم عشان الكاتيجوريز فلتر تتنفذ بعد getData في initState

    for (var i in favMealId) {
        int existedIndex = favoritMeals.indexWhere((element) => element.id == i);
        if (existedIndex < 0) {
          favoritMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == i));
        }
      }
      List fm=[];
      favoritMeals.forEach((fav) {
        availableMeals.forEach((av) {
          if(fav.id==av.id) fm.add(fav);
        });
      });
      favoritMeals=fm;
      if(favoritMeals==fm)print('mmmmm100: $favoritMeals');

    notifyListeners();
  }

  toggleFavorite(String mealId) async {
    final int existingIndex = favoritMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoritMeals.removeAt(existingIndex);
      favMealId.remove(mealId);
    } else {
      favoritMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      print('f3: $favMealId');
      favMealId.add(mealId);
      print('f4: $favMealId');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favMealId', favMealId);
    print('faaav: ${prefs.getStringList('favMealId')}');
    notifyListeners();
  }

  bool isMealFavorite(String id) {
    return favoritMeals.any((meal) => meal.id == id);
  }

  void categoryFillter() async {
    List<Category> ac = [];
    await availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((category) {
          if (category.id == catId) {
            if (!ac.any((c) => c.id == catId)) ac.add(category);
          }
        });
      });
    });
    //print(availableCategory.length);
    //print('----------');
    availableCategory = await ac;

    //print(availableCategory.length);
    //for(var i in availableCategory) print(i.id);
    //print('done');
    notifyListeners();
  }
}
