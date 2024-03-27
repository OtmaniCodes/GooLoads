part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}
class ThemeSettingState extends ThemeState {
  final ThemeData theme;
  final bool? isDarkOn;

  ThemeSettingState({required this.theme,this.isDarkOn});
}

 
