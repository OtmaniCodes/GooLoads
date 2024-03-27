import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gooloads/src/utils/constants/constants.dart';

class MyRatingStars extends StatelessWidget {
  final double percentage;
  double? size;
  MyRatingStars({Key? key, required this.percentage}) : super(key: key);

  MyRatingStars.withSize({required this.percentage, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
              getStarsRatingCount(0),
              (index) => SvgPicture.asset(
                    KStar20Ico,
                    height: 20,
                  )),
          ...List.generate(getStarsRatingCount(1),
              (index) => SvgPicture.asset(KStar15Ico, height: size ?? 20)),
          ...List.generate(getStarsRatingCount(2),
              (index) => SvgPicture.asset(KStar10Ico, height: size ?? 20)),
          ...List.generate(getStarsRatingCount(3),
              (index) => SvgPicture.asset(KStar05Ico, height: size ?? 20)),
          ...List.generate(getStarsRatingCount(4),
              (index) => SvgPicture.asset(KStarEmpty, height: size ?? 20)),
        ],
      ),
    );
  }

  int getStarsRatingCount(int index) {
    double twentiesCount = 0;
    double fifteensCount = 0;
    double tensCount = 0;
    double fivesCount = 0;
    twentiesCount = percentage / 20.0;
    if (twentiesCount < 5) {
      double remaining1 = percentage % 20;
      fifteensCount = remaining1 / 15.0;
      if (fifteensCount < 5) {
        double remaining2 = (fifteensCount * 15) % 15;
        tensCount = remaining2 / 10.0;
        if (tensCount < 5) {
          double remaining3 = (tensCount * 10) % 10;
          fivesCount = remaining3 / 5.0;
        }
      }
    }
    int emptyStarsCount = 5 -
        ((twentiesCount ~/ 1) +
            (fifteensCount ~/ 1) +
            (tensCount ~/ 1) +
            (fivesCount ~/ 1));
    List<int> starRatingCounts = [
      twentiesCount ~/ 1,
      fifteensCount ~/ 1,
      tensCount ~/ 1,
      fivesCount ~/ 1,
      emptyStarsCount
    ];
    return starRatingCounts[index];
  }
}
