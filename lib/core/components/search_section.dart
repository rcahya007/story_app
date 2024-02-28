import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story_app/core/assets/assets.gen.dart';
import 'package:story_app/core/constants/styles.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: SvgPicture.asset(
                  Assets.icon.search.path,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Color(0xff9FA5B2),
                    BlendMode.srcIn,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: body3.copyWith(
                  color: const Color(0xff9FA5B2),
                ),
                filled: true,
                fillColor: const Color(0xffF6F7F9),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xffF6F7F9),
              borderRadius: BorderRadius.circular(100),
            ),
            child: SvgPicture.asset(
              Assets.icon.sendCopy.path,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
