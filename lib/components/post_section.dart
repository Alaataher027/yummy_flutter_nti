import 'package:flutter/material.dart';
import 'package:yummy/components/post_card.dart';
import 'package:yummy/models/post.dart';

class PostsSection extends StatelessWidget {
  final List<Post> posts;
  const PostsSection({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Friend\'s Activity',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold, //
            ),
          ),
          ListView.builder(
            itemCount: posts.length,
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return PostCard(
                post: posts[index], //
              );
            }, //
          ), //
        ],
      ),
    );
  }
}
