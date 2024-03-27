import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/theme_bloc/theme_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingSection extends StatefulWidget {
  final String settingOption;
  const SettingSection({Key? key, required this.settingOption})
      : super(key: key);

  @override
  _SettingSectionState createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  bool isDarkOn = false;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSettingSectionHeadline(),
        MEDIUM_VSPACING,
        widget.settingOption == 'Theming'
            ? SwitchListTile(
                value: (themeBloc.state is ThemeSettingState)
                    ? (themeBloc.state as ThemeSettingState).isDarkOn!
                    : true,
                onChanged: (val) {
                  print(val);
                  setState(() {
                    isDarkOn = val;
                  });
                  themeBloc.add(ToggleThemeEvent(isDark: isDarkOn));
                },
                title: MyText(
                  txt:
                      "${((themeBloc.state is ThemeSettingState) ? (themeBloc.state as ThemeSettingState).isDarkOn! : true) ? "Dark" : "Light"} mode",
                  clr: Palette.KBlackClr,
                ),
              )
            : VoidSpacing,
      ],
    );
  }

  Widget getSettingSectionHeadline() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SMALL_HSPACING,
        Icon(Icons.brush),
        SMALL_HSPACING,
        MyText(
          txt: widget.settingOption,
          clr: Palette.KBlackClr,
          size: 24,
          boldness: FontWeight.bold,
        ),
      ],
    );
  }
}
