import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/classes/localization.dart';
import 'package:story_app/presentation/user/cubit/change_language/change_language_cubit.dart';

class FlagIcon extends StatelessWidget {
  const FlagIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(Icons.flag),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = Localization.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
              ),
            ),
            onTap: () {
              context.read<ChangeLanguageCubit>().changeLanguage(locale);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
