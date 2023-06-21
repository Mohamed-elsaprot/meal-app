import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ThemeProv with ChangeNotifier{

  MaterialColor primaryColor= Colors.pink;
  MaterialColor accentColor=Colors.amber;

  ThemeMode th= ThemeMode.system;
  String themeText='s';

  void themeModeChange(ThemeMode newMode){
    th=newMode;
    setThemeText(newMode);
    notifyListeners();

  }

  void setThemeText(ThemeMode t)async{
    if(t == ThemeMode.system){themeText='s';}
    else if(t== ThemeMode.light){themeText='l';}
    else if(t== ThemeMode.dark){themeText='d';}
    notifyListeners();
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString('theme', themeText);
  }

  void getThemeMode() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    themeText=prefs.getString('theme')??'s';
    if(themeText=='s')th=ThemeMode.system;
    else if(themeText=='l')th=ThemeMode.light;
    else if(themeText=='d')th=ThemeMode.dark;
    notifyListeners();
  }


  void onChange(color,text)async{
    text=='primary'?primaryColor=_toMaterialColor(color.hashCode)
        :accentColor=_toMaterialColor(color.hashCode);
    notifyListeners();
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setInt('p', primaryColor.value);
    prefs.setInt('a', accentColor.value);
  }

  void getColors()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    //prefs.clear();
    primaryColor = _toMaterialColor(prefs.getInt('p'))?? Colors.pink;
    accentColor= _toMaterialColor(prefs.getInt('a'))?? Colors.amber ;
    notifyListeners();
  }

  MaterialColor _toMaterialColor(int hashCode) {
    if(hashCode==null)return null;
    else
      return MaterialColor(
        hashCode,
        <int, Color>{
          50: Color(0xFFFCE4EC),
          100: Color(0xFFF8BBD0),
          200: Color(0xFFF48FB1),
          300: Color(0xFFF06292),
          400: Color(0xFFEC407A),
          500: Color(hashCode),
          600: Color(0xFFD81B60),
          700: Color(0xFFC2185B),
          800: Color(0xFFAD1457),
          900: Color(0xFF880E4F),

        }
    );
  }





}