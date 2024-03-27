import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

import 'constants/palette.dart';

class ReusedWidgets {
  static BorderRadius defaultBorRadCir = BorderRadius.circular(KDefaultPadd);
  static BoxShadow defaultBoxShadow = BoxShadow(
    color: Palette.KShadowClr,
    offset: Offset(0, 3),
    blurRadius: 6,
  );
  static materialEffect(Widget widget,
          {VoidCallback? onPress, bool isCircle = false}) =>
      Material(
          color: Palette.KTransparentClr,
          child: InkWell(
              borderRadius: isCircle
                  ? BorderRadius.all(Radius.elliptical(9999, 9999))
                  : null,
              onTap: onPress ?? () {},
              child: widget));

  static blurryBg({required Widget widget}) {
    return Container(
      color: Palette.KWhiteClr.withOpacity(0.4),
      alignment: Alignment.center,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: GestureDetector(
          onTap: () {},
          child: widget,
        ),
      ),
    );
  }

  static Shimmer shimmerLoading = Shimmer.fromColors(
    child: Container(color: Colors.white),
    baseColor: Palette.KWhiteClr,
    highlightColor: Palette.KWhitishClr,
  );

  static IconButton popButton(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).accentColor),
        onPressed: () => Navigator.pop(context),
      );
}
