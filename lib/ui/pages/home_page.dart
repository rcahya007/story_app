import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:story_app/model/response/stories_response_model.dart';
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
  late StoriesResponseModel dataStories;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final data = context.read<StoriesProvider>().getStories();
    dataStories = await data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<StoriesProvider>(
          builder: (context, value, child) {
            if (value.isLoadingStories) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
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
                        itemCount: dataStories.listStory!.length,
                        itemBuilder: (context, index) {
                          return CardItem(
                            listStory: dataStories.listStory![index],
                            urlImageUser:
                                'https://picsum.photos/${index + 100}/200',
                            onTapped: (_) {
                              widget
                                  .onTapped(dataStories.listStory![index].id!);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
