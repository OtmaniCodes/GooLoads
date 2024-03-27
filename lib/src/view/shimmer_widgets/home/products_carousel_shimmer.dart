import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:shimmer/shimmer.dart';

class ProductsCarouselShimmer extends StatefulWidget {
  const ProductsCarouselShimmer({Key? key}) : super(key: key);

  @override
  _ProductsCarouselShimmerState createState() =>
      _ProductsCarouselShimmerState();
}

class _ProductsCarouselShimmerState extends State<ProductsCarouselShimmer> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.5,
      keepPage: false,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      pageSnapping: true,
      itemBuilder: (BuildContext context, int index) {
        return shimmeredProductCard(index);
      },
    );
  }

  Widget shimmeredProductCard(int index) {
    return Shimmer.fromColors(
      baseColor: Palette.KWhiteClr,
      highlightColor: Palette.KWhitishClr,
      child: Transform.scale(
        scale: index == 0 ? 1.0 : 0.9,
        child: SizedBox(
          width: 20,
          child: MyContainer(
            withShadow: false,
              givenMarg:
                  EdgeInsets.symmetric(horizontal: KDefaultPadd, vertical: 5.0),
              givenPadd: EdgeInsets.zero,
              kiddo: Container()),
        ),
      ),
    );
  }
}
