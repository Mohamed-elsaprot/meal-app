import 'package:flutter/material.dart';

enum Complexity{
  Simple,
  Challenging,
  Hard
}

enum Affordability{
  Affordable,
  Pricey,
  Luxurious
}

class Meal{
 var id;
 var categories;
 var title;
 var imageUrl;
 var ingredients;
 var steps;
 var duration;
 var complexity;
 var affordability;
 var isGlutenFree;
 var isLactoseFree;
 var isVegan;
 var isVegetarian;

 Meal({
   @required this.id,
   @required this.categories,
   @required this.title,
   @required this.imageUrl,
   @required this.ingredients,
   @required this.steps,
   @required this.duration,
   @required this.complexity,
   @required this.affordability,
   @required this.isGlutenFree,
   @required this.isLactoseFree,
   @required this.isVegan,
   @required this.isVegetarian,
 });




}