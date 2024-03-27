import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';

class MyCornerButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  const MyCornerButton({Key? key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          bottomRight: Radius.circular(KDefaultPadd),
        ),
        color: Palette.KBlackClr,
      ),
      child: Material(
        color: Palette.KTransparentClr,
        child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            bottomRight: Radius.circular(KDefaultPadd),
          ),
          onTap: onPressed,
          child: Container(
            height: 50,
            width: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5.0),
              child: Icon(
                icon,
                color: Palette.KWhiteClr,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
