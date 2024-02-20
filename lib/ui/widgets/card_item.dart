import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';

class CardItem extends StatelessWidget {
  final String urlImage;
  final String userName;
  final String urlImageUser;
  const CardItem({
    Key? key,
    required this.urlImage,
    required this.userName,
    required this.urlImageUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    userName,
                    style: body3,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  '1 hour ago',
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
              urlImage,
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
    );
  }
}
