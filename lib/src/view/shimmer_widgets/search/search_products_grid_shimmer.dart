import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/view/shimmer_widgets/shimmer_box.dart';

class SearchProductsGridShimmer extends StatelessWidget {
  const SearchProductsGridShimmer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _randomHeights = [130, 200, 150, 270, 250];
    return StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true, crossAxisCount: 2,
        itemCount: 8,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(KDefaultPadd),
          child: ClipRRect(
            borderRadius: ReusedWidgets.defaultBorRadCir,
            child: ShimmerBox.withHeight(_randomHeights[Random().nextInt(_randomHeights.length)].toDouble())),
        ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      );
  }
}