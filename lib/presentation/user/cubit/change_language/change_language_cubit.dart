import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/datasources/auth_local_language_datasource.dart';

part 'change_language_state.dart';
part 'change_language_cubit.freezed.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  final AuthLocalLanguageDatasource _authLocalLanguageDatasource;
  ChangeLanguageCubit(this._authLocalLanguageDatasource)
      : super(const ChangeLanguageState.initial()) {
    getLocalLanguage();
  }

  changeLanguage(Locale locale) async {
    await _authLocalLanguageDatasource.saveLanguange(locale);
    emit(ChangeLanguageState.loaded(locale));
  }

  getLocalLanguage() async {
    final locale = await _authLocalLanguageDatasource.getLocalLanguage();
    emit(ChangeLanguageState.loaded(locale!));
  }
}
