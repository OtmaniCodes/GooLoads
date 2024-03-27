import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:shimmer/shimmer.dart';

class CategoryChipsShimmer extends StatelessWidget {
  const CategoryChipsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenCredentials.screenHeight(context) * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return getShimmeredCategory(index);
        },
      ),
    );
  }

  Widget getShimmeredCategory(int index) {
    return Shimmer.fromColors(
      baseColor: Palette.KWhiteClr,
      highlightColor: Palette.KWhitishClr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
        child: Chip(
          elevation: 3.0,
          labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          label: Text(index == 0? "dddddddddddddddddd": "dd")
        ),
      ),
    );
  }
}
