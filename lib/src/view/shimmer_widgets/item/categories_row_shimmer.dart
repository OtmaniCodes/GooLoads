import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/shimmer_widgets/shimmer_box.dart';

class CategoriesRowShimmer extends StatelessWidget {
  const CategoriesRowShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) => Padding(
          padding: const EdgeInsets.all(KDefaultPadd),
          child: shimmerdCategoryCard(index))));
  }

  Widget shimmerdCategoryCard(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(KDefaultPadd),
      child: ShimmerBox(height: 50, width: 80));
  }
}
