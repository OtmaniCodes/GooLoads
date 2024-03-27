import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class MyBlackButton extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;
  const MyBlackButton({
    Key? key,
    required this.txt,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.KBlackClr,
      ),
      child: Material(
        color: Palette.KTransparentClr,
        child: InkWell(
          onTap: this.onPressed,
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            child: MyText(
              txt: this.txt.toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }
}
