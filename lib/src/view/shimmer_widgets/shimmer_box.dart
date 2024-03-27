import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  double? height;
  double? width;
  Widget? child;
  ShimmerBox({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  ShimmerBox.withHeight(double height) {
    this.height = height;
    this.width = double.infinity;
  }

  ShimmerBox.withWidth(double width) {
    this.width = width;
    this.height = double.infinity;
  }

  ShimmerBox.withChild(Widget child){
    this.child = child;
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:  Palette.KWhiteClr,
      highlightColor:  Palette.KWhitishClr,
      child: Container(
        color: Palette.KWhiteClr,
        height: this.height,
        width: this.width,
        child: this.child,
      ),
    );
  }
}
