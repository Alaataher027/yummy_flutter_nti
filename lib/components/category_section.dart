import 'package:flutter/material.dart';
import 'package:yummy/components/catigory_card.dart';
import 'package:yummy/models/food_category.dart';

class CategorySection extends StatelessWidget {
  final List<FoodCategory> categories;
  const CategorySection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories', 
            style: TextStyle(
              fontSize: 25.0, 
              fontWeight: FontWeight.bold, 
            ),
          ),
          SizedBox(
            height: 275.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: CatigoryCard(
                    foodCategory: categories[index],
                  ),
                );
              }, //
            ),
          ),
        ],
      ),
    );
  }
}
