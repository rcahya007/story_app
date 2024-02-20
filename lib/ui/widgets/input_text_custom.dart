import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';

// ignore: must_be_immutable
class InputTextCustom extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  bool? obscureText;

  InputTextCustom({
    Key? key,
    this.hintText,
    required this.isPassword,
    required this.controller,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<InputTextCustom> createState() => _InputTextCustomState();
}

class _InputTextCustomState extends State<InputTextCustom> {
  @override
  void dispose() {
    widget.controller!.dispose();
    super.dispose();
  }

  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      style: body3,
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      decoration: InputDecoration(
        constraints: const BoxConstraints(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 13,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide.none,
        ),
        fillColor: const Color(0xffF3F5F7),
        filled: true,
        hintText: widget.hintText,
        hintStyle: body3.copyWith(
          color: const Color(0xffBDBDBD),
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: SvgPicture.asset(
                  _isObscured ? Assets.icon.hide : Assets.icon.show,
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
