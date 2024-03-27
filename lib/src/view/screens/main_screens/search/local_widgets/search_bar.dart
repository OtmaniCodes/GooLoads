import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/api_bloc/search_products_bloc/search_products_bloc.dart';
// import 'package:gooloads/src/blocs/api_bloc/api_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer? debouncer;

  void debounce(VoidCallback func) {
    final Duration duration = Duration(seconds: 1);
    if (debouncer != null) debouncer!.cancel();
    debouncer = Timer(duration, func);
  }

  @override
  void dispose() {
    debouncer!.cancel();
    super.dispose();
  }

  void searchProduct(BuildContext context, String query) =>
  debounce(() => context.read<SearchProductsBloc>().add(SearchProductsByNameEvent(query: query)));

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      givenPadd: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
      kiddo: Row(
        children: [
          SvgPicture.asset(KSearchIco, height: 25),
          MEDIUM_HSPACING,
          Expanded(
            child: TextField(
              onChanged: (val) => searchProduct(context, val),
              cursorColor: Palette.KBlackClr,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search for a product",
                hintStyle: defaultTS.copyWith(color: Palette.KKGreyShade03Clr),
              ),
            ),
          ),
        ],
      ),
    );
  }  
}
