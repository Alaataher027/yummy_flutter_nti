import 'package:flutter/material.dart';
import 'package:yummy/models/food_category.dart';

////////// Does Not Used ///////////////////
class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.foodCategory});

  final FoodCategory foodCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(14 as Radius)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.asset(foodCategory.imageUrl),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Text(
                    "Yummy",
                    style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                  ),
                ),

                const Positioned(
                  right: 1,
                  bottom: 1,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      "Yummy",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              foodCategory.name,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              foodCategory.numberOfRestaurants.toString(),
              style: TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
