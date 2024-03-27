import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFilterButton extends StatelessWidget {
  const SearchFilterButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyContainer(
                      givenPadd: EdgeInsets.zero,
                      kiddo: Material(
                        color: Palette.KTransparentClr,
                        child: InkWell(
                           borderRadius: BorderRadius.circular(KDefaultPadd),
                          onTap: (){},
                          child: Container(
                            padding: const EdgeInsets.all(KDefaultPadd),
                            // color: Colors.red,
                            child: SvgPicture.asset(KFilterIco, height: 25),
                          ),
                        ),
                      ),
                    );
  }
}