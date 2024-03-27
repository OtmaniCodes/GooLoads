import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class ProductTitle extends StatelessWidget {
  final String title;
  const ProductTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(KDefaultPadd),
      child: MyText(
        txt: this.title,
        clr: Palette.KBlackClr,
        size: 24,
        boldness: FontWeight.bold,
      ),
    );
  }
}
