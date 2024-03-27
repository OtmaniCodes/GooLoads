import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';

class MyContainer extends StatelessWidget {
  final Widget kiddo;
  final EdgeInsetsGeometry? givenPadd;
  final EdgeInsetsGeometry? givenMarg;
  final Color? givenClr;
  final bool withShadow;
  final withBorder;
  const MyContainer({
    Key? key,
    required this.kiddo,
    this.givenPadd,
    this.givenMarg,
    this.givenClr,
    this.withShadow = true,
    this.withBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.givenMarg ?? const EdgeInsets.all(KDefaultPadd),
      padding: this.givenPadd ?? const EdgeInsets.all(KDefaultPadd),
      decoration: BoxDecoration(
        borderRadius: ReusedWidgets.defaultBorRadCir,
        color: givenClr ?? Palette.KWhiteClr,
        border: this.withBorder ? Border.all(color: Palette.KBlackClr):null,
        boxShadow: this.withShadow
            ? [
                ReusedWidgets.defaultBoxShadow
              ]
            : null,
      ),
      child: this.kiddo,
    );
  }
}
