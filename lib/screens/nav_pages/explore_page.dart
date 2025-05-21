import 'package:flutter/material.dart';
import 'package:yummy/api/mock_yummy_service.dart';
import 'package:yummy/components/category_section.dart';
import 'package:yummy/components/post_section.dart';
import 'package:yummy/components/restaurant_section.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MockYummyService().getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final foodNearMe = snapshot.data?.restaurants ?? [];
          final categories = snapshot.data?.categories ?? [];
          final post = snapshot.data?.friendPosts ?? [];
          return ListView(
            children: [
              RestaurantsSection(restaurants: foodNearMe),
              CategorySection(categories: categories),
              PostsSection(posts: post),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }, 
    );
  }
}
