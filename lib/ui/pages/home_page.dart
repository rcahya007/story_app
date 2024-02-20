import 'package:flutter/material.dart';

import 'package:story_app/ui/widgets/card_item.dart';
import 'package:story_app/ui/widgets/filter_by.dart';
import 'package:story_app/ui/widgets/search_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SearchSection(),
            const FilterBy(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xffF6F7F9),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => CardItem(
                      urlImage: 'https://picsum.photos/${index + 100}/200',
                      userName: 'User ${index + 1}',
                      urlImageUser: 'https://picsum.photos/${index + 100}/200',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
