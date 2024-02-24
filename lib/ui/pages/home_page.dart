import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/ui/widgets/card_item.dart';
import 'package:story_app/ui/widgets/filter_by.dart';
import 'package:story_app/ui/widgets/search_section.dart';

class HomePage extends StatefulWidget {
  final Function(String) onTapped;
  const HomePage({
    super.key,
    required this.onTapped,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var dataStories = context.watch<StoriesProvider>().dataStories;
    return Scaffold(
      body: SafeArea(
        child: context.watch<StoriesProvider>().isLoadingStories
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                          itemCount: dataStories.length,
                          itemBuilder: (context, index) {
                            return CardItem(
                              listStory: dataStories[index],
                              urlImageUser:
                                  'https://ui-avatars.com/api/?name=${dataStories[index].name!}',
                              onTapped: (_) {
                                widget.onTapped(dataStories[index].id!);
                              },
                            );
                          },
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
