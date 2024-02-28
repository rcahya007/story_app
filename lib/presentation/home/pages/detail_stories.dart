import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/presentation/home/bloc/get_detail_stories/get_detail_stories_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_all_stories/get_all_stories_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:story_app/core/assets/assets.gen.dart';
import 'package:story_app/core/constants/styles.dart';

class DetailStories extends StatelessWidget {
  final String storiesId;
  const DetailStories({
    super.key,
    required this.storiesId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<GetDetailStoriesBloc, GetDetailStoriesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox();
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (data) {
                  String timeString = data.story!.createdAt.toString();
                  DateTime dateTime = DateTime.parse(timeString);
                  DateTime now = DateTime.now();
                  String timeAgo =
                      timeago.format(now.subtract(now.difference(dateTime)));
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.goNamed('Home');
                                context.read<GetAllStoriesBloc>().add(
                                    const GetAllStoriesEvent.getAllStories());
                              },
                              child: SvgPicture.asset(
                                Assets.icon.arrowLeft1.path,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              Assets.icon.heart1.path,
                              height: 24,
                              width: 24,
                              fit: BoxFit.scaleDown,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(
                              Assets.icon.plusCircle1.path,
                              height: 24,
                              width: 24,
                              fit: BoxFit.scaleDown,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(
                              Assets.icon.upload.path,
                              height: 24,
                              width: 24,
                              fit: BoxFit.scaleDown,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  backgroundImage: NetworkImage(
                                    'https://ui-avatars.com/api/?name=${data.story!.name}',
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    data.story!.name!,
                                    style: body3,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  timeAgo,
                                  style: body4.copyWith(
                                    color: const Color(0xffBDBDBD),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Image.network(
                        data.story!.photoUrl!,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '125',
                                  style: body4.copyWith(
                                    color: const Color(0xffBDBDBD),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SvgPicture.asset(
                                  Assets.icon.eye.path,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '125',
                                  style: body4.copyWith(
                                    color: const Color(0xffBDBDBD),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SvgPicture.asset(
                                  Assets.icon.chatFill.path,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '125',
                                  style: body4.copyWith(
                                    color: const Color(0xffBDBDBD),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SvgPicture.asset(
                                  Assets.icon.heartFill.path,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                          top: 10.25,
                          bottom: 16,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: title1,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              data.story!.description!,
                              style: body4.copyWith(
                                color: const Color(0xffBDBDBD),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
