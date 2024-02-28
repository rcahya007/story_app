import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_all_stories/get_all_stories_bloc.dart';

import 'package:story_app/core/components/card_item.dart';
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
  @override
  void initState() {
    context.read<GetAllStoriesBloc>().add(
          const GetAllStoriesEvent.getAllStories(),
        );
    context.read<ChangeIndexMenuBloc>().add(
          const ChangeIndexMenuEvent.changeIndexMenu(0),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GetAllStoriesBloc, GetAllStoriesState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox();
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (data) {
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
                            itemCount: data.listStory!.length,
                            itemBuilder: (context, index) {
                              return CardItem(
                                listStory: data.listStory![index],
                                urlImageUser:
                                    'https://ui-avatars.com/api/?name=${data.listStory![index].name!}',
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
