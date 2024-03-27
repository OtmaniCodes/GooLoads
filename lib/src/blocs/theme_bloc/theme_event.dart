part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {
  final bool isDark;

  ToggleThemeEvent({this.isDark = false});
}

class GetSavedThemeEvent extends ThemeEvent{}