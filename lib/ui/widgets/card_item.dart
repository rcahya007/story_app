import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/model/response/stories_response_model.dart';

class CardItem extends StatelessWidget {
  final ListStory listStory;
  final String urlImageUser;
  final dynamic Function(String) onTapped;
  const CardItem({
    super.key,
    required this.listStory,
    required this.urlImageUser,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    String timeString = listStory.createdAt!.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime now = DateTime.now();
    String timeAgo = timeago.format(now.subtract(now.difference(dateTime)));
    return GestureDetector(
      onTap: () {
        onTapped(listStory.id!);
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
                      urlImageUser,
                    ),
                    maxRadius: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      listStory.name!,
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
                listStory.photoUrl!,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.icon.plusCircle1,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                  const Spacer(),
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
                    Assets.icon.chat,
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
                    Assets.icon.heart1,
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
