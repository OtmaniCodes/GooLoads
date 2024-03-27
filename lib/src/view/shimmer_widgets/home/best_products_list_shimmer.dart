import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import '../shimmer_box.dart';

class BestProductsListShimmer extends StatelessWidget {
  const BestProductsListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (_, index) {
          return Divider(
            height: KMediumPadd,
          );
        },
        itemCount: 10,
        itemBuilder: (_, index) {
          return getShimmeredListTile(context);
        },
      ),
    );
  }

  Widget getShimmeredListTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(KDefaultPadd),
            child: ShimmerBox(
              height: 150,
              width: 150,
            ),
          ),
          SMALL_HSPACING,
          Expanded(
              child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerBox.withHeight(15),
                    const SizedBox(height: 8),
                    ShimmerBox.withHeight(15),
                    const SizedBox(height: 8),
                    ShimmerBox.withHeight(15),
                  ],
                ),
                ShimmerBox.withHeight(15),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
