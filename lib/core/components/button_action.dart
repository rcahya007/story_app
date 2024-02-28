import 'package:flutter/material.dart';

import 'package:story_app/core/constants/styles.dart';

class ButtonAction extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  const ButtonAction({
    super.key,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff5151C6),
              Color(0xff888BF4),
            ],
          ),
        ),
        child: Text(
          text!,
          style: bodySemiBold.copyWith(
            color: whiteColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
