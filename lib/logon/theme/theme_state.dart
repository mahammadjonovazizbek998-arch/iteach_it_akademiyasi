part of 'theme_cubit.dart';
enum AppLanguage { uz, ru, en }
@immutable
sealed class ThemeState {
  final bool? theme;
  final AppLanguage? language;
  const ThemeState({ this.theme,this.language});
}

final class ThemeInitial extends ThemeState {
 const  ThemeInitial({required super.theme, required super.language});
}


