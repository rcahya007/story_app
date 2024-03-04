import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:story_app/core/assets/assets.gen.dart';
import 'package:story_app/core/constants/styles.dart';
import 'package:story_app/data/model/response/stories_response_model.dart';
import 'package:story_app/presentation/home/bloc/get_detail_stories/get_detail_stories_bloc.dart';

class CardItem extends StatefulWidget {
  final ListStory listStory;
  final String urlImageUser;
  const CardItem({
    super.key,
    required this.listStory,
    required this.urlImageUser,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  String? dataLocaiton;

  @override
  void initState() {
    super.initState();
    getDataLocation();
  }

  getDataLocation() async {
    try {
      final info = await geo.placemarkFromCoordinates(
          widget.listStory.lat!, widget.listStory.lon!);
      final place = info[0];
      final street = place.street!;
      final address =
          '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      setState(() {
        dataLocaiton = '$street, $address';
      });
    } catch (e) {
      setState(() {
        dataLocaiton = 'Location not available';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeString = widget.listStory.createdAt!.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime now = DateTime.now();
    String timeAgo = timeago.format(now.subtract(now.difference(dateTime)));

    return GestureDetector(
      onTap: () {
        context.goNamed(
          'DetailStories',
          pathParameters: {'storiesId': widget.listStory.id!},
        );
        context
            .read<GetDetailStoriesBloc>()
            .add(GetDetailStoriesEvent.getDetailStories(widget.listStory.id!));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    backgroundImage: NetworkImage(
                      widget.urlImageUser,
                    ),
                    maxRadius: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.listStory.name!,
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 224,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.listStory.photoUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (widget.listStory.lat != null && widget.listStory.lon != null)
                      ? Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color(0xff5151C6),
                              ),
                              Expanded(
                                child: Text(
                                  dataLocaiton ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    '20',
                    style: body4.copyWith(
                      color: const Color(0xff828282),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  SvgPicture.asset(
                    Assets.icon.chat.path,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '125',
                    style: body4.copyWith(
                      color: const Color(0xff828282),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  SvgPicture.asset(
                    Assets.icon.heart1.path,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
