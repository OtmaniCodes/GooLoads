import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class CategoriesRow extends StatelessWidget {
  final List? categoriesNames;
  const CategoriesRow({Key? key, this.categoriesNames}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => categoriesNames![index])
          .map((name) => CategoryCard(name))
          .toList(),
    );
  }

  Widget CategoryCard(String name) {
    return MyContainer(
      kiddo: SizedBox(
        height: 50,
        width: 80,
        child: Center(
          child: MyText(
            txt: name,
            clr: Palette.KBlackClr,
            alignment: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
