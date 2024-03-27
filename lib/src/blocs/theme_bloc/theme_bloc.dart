import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/prefrences.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/utils/theme.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    AppTheme appTheme = AppTheme();
    try {
      if (event is ToggleThemeEvent) {
        ThemeData yieldedTheme;
        bool isDarkOn = false;
        if (event.isDark) {
          yieldedTheme = appTheme.getDarkTheme;
          isDarkOn = true;
          serviceLocator<AppPrefrences>().saveThemeId(1);
        } else {
          yieldedTheme = appTheme.getLightTheme;
          serviceLocator<AppPrefrences>().saveThemeId(0);
        }
        yield ThemeSettingState(theme: yieldedTheme, isDarkOn: isDarkOn);
      } else if (event is GetSavedThemeEvent) {
        print("HELLO");
        int savedThemeId =
            await serviceLocator<AppPrefrences>().getSavedThemeId();
        late ThemeData yieldedTheme;
        bool isDarkOn = false;
        switch (savedThemeId) {
          case 0:
            yieldedTheme = appTheme.getLightTheme;

            break;
          case 1:
            yieldedTheme = appTheme.getDarkTheme;
            isDarkOn = true;
            break;
        }
        print("THEME IS: $yieldedTheme");
        yield ThemeSettingState(theme: yieldedTheme, isDarkOn: isDarkOn);
      }
    } catch (error) {
      print(error);
    }
  }
}
