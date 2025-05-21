import 'package:flutter/material.dart';
import 'package:yummy/models/food_category.dart';

class CatigoryCard extends StatelessWidget {
  const CatigoryCard({super.key, required this.foodCategory});

  final FoodCategory foodCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              foodCategory.imageUrl,
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              fit: BoxFit.cover,
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
