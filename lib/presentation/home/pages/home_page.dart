import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/components/card_item.dart';
import 'package:story_app/core/constants/styles.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_all_stories/get_all_stories_bloc.dart';

import 'package:story_app/core/components/filter_by.dart';
import 'package:story_app/core/components/search_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? pageItems = 1;
  final ScrollController scrollController = ScrollController();
  final listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    context.read<GetAllStoriesBloc>().add(
          const GetAllStoriesEvent.getAllStories(1),
        );
    context.read<ChangeIndexMenuBloc>().add(
          const ChangeIndexMenuEvent.changeIndexMenu(0),
        );

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (mounted) {
          pageItems = pageItems! + 1;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<GetAllStoriesBloc>().add(
                  GetAllStoriesEvent.getAllStories(pageItems),
                );
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
                controller: scrollController,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xffF6F7F9),
                  child: BlocConsumer<GetAllStoriesBloc, GetAllStoriesState>(
                    listener: (context, state) {
                      state.maybeWhen(
                          orElse: () {},
                          loaded: (data) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(
                                milliseconds: 500,
                              ),
                              content: Center(
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Loading...'),
                                  ],
                                ),
                              ),
                            ));
                          });
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Text(
                            'No data, please reload or check your internet connection',
                            style: body1,
                          );
                        },
                        loaded: (data) {
                          return ListView.builder(
                            key: listKey,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CardItem(
                                listStory: data[index],
                                urlImageUser:
                                    'https://ui-avatars.com/api/?name=${data[index].name!}',
                              );
                            },
                          );
                        },
                        error: (message) {
                          return SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: Text(
                                'Error, please reload or check your internet connection',
                                style: body1,
                              ),
                            ),
                          );
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
