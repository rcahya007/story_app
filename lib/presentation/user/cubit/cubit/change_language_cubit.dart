import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_language_state.dart';
part 'change_language_cubit.freezed.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit()
      : super(const ChangeLanguageState.initial(Locale('id')));

  changeLanguage(Locale locale) {
    emit(const ChangeLanguageState.loading());
    emit(ChangeLanguageState.loaded(locale));
  }
}
