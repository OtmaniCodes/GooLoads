import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/shimmer_widgets/shimmer_box.dart';

class SwipeableProductImagesShimmer extends StatelessWidget {
  const SwipeableProductImagesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenCredentials.screenWidth(context) * 0.05),
      child: ShimmerBox.withHeight(ScreenCredentials.screenHeight(context) * 0.45));
  }
}
