import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:shimmer/shimmer.dart';

class FavGridShimmer extends StatelessWidget {
  const FavGridShimmer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(vertical: 20),
      physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 0.62,
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          children: [
            ...List.generate(10,
                (index) => shimmeredProductCard(index)
                ),
          ]);
  }

  Widget shimmeredProductCard(int index) {
    return Shimmer.fromColors(
      baseColor: Palette.KWhiteClr,
      highlightColor: Palette.KWhitishClr,
      child:  MyContainer(
            withShadow: false,
              givenMarg: EdgeInsets.zero,
              givenPadd: EdgeInsets.zero,
              kiddo: Container()),
    );
  }
}