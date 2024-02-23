import 'package:flutter/material.dart';
import 'package:story_app/core/styles.dart';

class PostStories extends StatelessWidget {
  const PostStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: const Text(
                'New Stories',
                style: heading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
