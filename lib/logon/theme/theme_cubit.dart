import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(language: AppLanguage.uz, theme: true));
}
