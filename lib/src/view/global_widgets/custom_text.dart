import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';

class MyText extends StatelessWidget {
  final String txt;
  final Color? clr;
  final int? maxLines;
  final double? size;
  final bool isOverflow;
  final bool isBold;
  final FontWeight? boldness;
  final TextAlign? alignment;

  const MyText(
      {Key? key,
      required this.txt,
      this.clr,
      this.size,
      this.maxLines,
      this.boldness,
      this.isBold = false,
      this.isOverflow = false,
      this.alignment})
      : super(key: key);

  Widget build(BuildContext context) {
    return Text(
      txt,
      maxLines: this.maxLines,
      style: defaultTS.copyWith(
        color: clr ?? Palette.KWhiteClr,
        fontSize: size ?? 18,
        fontWeight: isBold?FontWeight.bold:boldness,
      ),
      overflow: isOverflow?TextOverflow.ellipsis:null,
      textAlign: alignment,
    );
  }
}
