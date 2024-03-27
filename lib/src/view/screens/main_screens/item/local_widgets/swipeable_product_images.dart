import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/logger.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';

class SwipeableProductImages extends StatefulWidget {
  final List images;
  const SwipeableProductImages({Key? key, required this.images})
      : super(key: key);

  @override
  _SwipeableProductImagesState createState() => _SwipeableProductImagesState();
}

class _SwipeableProductImagesState extends State<SwipeableProductImages> {
  late PageController _pageController;
  int _pageCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageCurrentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _clearCachedNetworkImages();
    super.dispose();
  }


  _clearCachedNetworkImages() async {
    DevLogger.log('clearing urls from cach...');
    for (String _imageUrl in widget.images){
      await CachedNetworkImage.evictFromCache(_imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: ScreenCredentials.screenHeight(context) * 0.45,
          margin: EdgeInsets.symmetric(horizontal: ScreenCredentials.screenWidth(context) * 0.05),
          decoration: BoxDecoration(border: Border.all(color: Palette.KBlackClr)),
          child: PageView.builder(
            onPageChanged: (newPageIndex) {
              HapticFeedback.mediumImpact();
              setState.call(()=>_pageCurrentIndex = newPageIndex);
            },
            itemCount: widget.images.length,
            itemBuilder: (_, int index) => Container(
              child: CachedNetworkImage(fit: BoxFit.fill,
              imageUrl: widget.images[index]??'',
              placeholder: (context, url) => ReusedWidgets.shimmerLoading,
              errorWidget: (context, url, error) => ReusedWidgets.shimmerLoading))
          ),
        ),
        SMALL_VSPACING,
        getDotsRow()
      ],
    );
  }

  Widget getDotsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.images.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Icon(
            index == _pageCurrentIndex ? Icons.circle : Icons.circle_outlined,
            size: index == _pageCurrentIndex ? 15 : 12,
          ),
        ),
      ),
    );
  }
}
