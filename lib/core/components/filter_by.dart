import 'package:flutter/material.dart';
import 'package:story_app/core/constants/styles.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({
    super.key,
  });

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  int itemIndex = 0;

  final itemName = [
    'Popular',
    'Trending',
    'Liked',
    'Following',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemName.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                itemIndex = index;
              });
            },
            child: Container(
              width: 118,
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: itemIndex == index
                    ? const Color(0xffF1F1FE)
                    : Colors.transparent,
              ),
              child: itemIndex == index
                  ? ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xff5151C6),
                          Color(0xff888BF4),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        itemName[index],
                        style: title2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Text(
                      itemName[index],
                      style: title3.copyWith(
                        color: const Color(0xffBDBDBD),
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          );
        },
      ),
    );
  }
}
