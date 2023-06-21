import 'package:flutter/material.dart';
import 'package:meal_app/provider/lang_prov.dart';
import 'package:provider/provider.dart';
import '../screens/meal_details_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  //final Function removeItem;

  MealItem({
    @required this.id,
    @required this.imageUrl,
    @required this.title,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    // @required  this.removeItem
  });

  String get comlexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'simple';
        break;
      case Complexity.Challenging:
        return 'challenging';
        break;
      case Complexity.Hard:
        return 'hard';
        break;
      default:
        return 'unkwon';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'affordable';
        break;
      case Affordability.Luxurious:
        return 'luxurious';
        break;
      case Affordability.Pricey:
        return 'pricey';
        break;
      default:
        return 'unkwon';
    }
  }

  void selectMeal(ctx) {
    Navigator.of(ctx)
        .pushNamed(
      MealDetailsScreen.routName,
      arguments: id,
    )
        .then((result) {
      //if( result != null) removeItem(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context);
    var lan = Provider.of<LanguageProvider>(context, listen: false);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 20,
        //shadowColor: Colors.black,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      // bottomLeft: Radius.circular(15)
                    ),
                    child: Hero(
                      tag: id,
                      child: InteractiveViewer(
                        child:FadeInImage(
                          placeholder: AssetImage('assets/images/image.jpg'),
                          image:NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(5)),
                      width: 220,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        lan.getTexts('meal-$id'),
                        style: TextStyle(fontSize: 25, color: Colors.white),
                        //  softWrap: true,
                        //  overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$duration  ${lan.getTexts('min')}',
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        lan.getTexts('${complexity}'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                      ),
                      Text(
                        lan.getTexts('${affordability}'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
