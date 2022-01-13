import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendPosts;
  const FriendPostListView({
    Key? key,
    required this.friendPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Social Chefs 👩‍🍳',
              style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 16),
          // TODO: Add PostListView
          ListView.separated(
            primary: false,

            // disables scrolling for this list view
            // will propagate up to parent list view
            physics: const NeverScrollableScrollPhysics(),

            // true creates a fixed-length scrollable list (fixed height)
            // false will give unbounded height error
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // for every item in friendPosts list, create tile
              return FriendPostTile(post: friendPosts[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemCount: friendPosts.length,
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
