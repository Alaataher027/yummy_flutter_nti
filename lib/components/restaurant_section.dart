import 'package:flutter/material.dart';
import 'package:yummy/components/restaurant_card.dart';
import 'package:yummy/models/restaurant.dart';

class RestaurantsSection extends StatelessWidget {
  final List<Restaurant> restaurants;
  const RestaurantsSection({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Food Near Me',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (_, index) {
                return  SizedBox(
                  width: 250.0,
                  child: RestaurantCard(restaurant: restaurants[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
