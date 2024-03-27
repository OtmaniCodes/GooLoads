import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/api_bloc/categories_bloc/categories_bloc.dart';
import 'package:gooloads/src/blocs/api_bloc/product_by_category_id_bloc/product_by_category_id_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/shimmer_widgets/home/category_chips_shimmer.dart';


class CategroyChips extends StatefulWidget {
  const CategroyChips({Key? key}) : super(key: key);

  @override
  _CategroyChipsState createState() => _CategroyChipsState();
}

class _CategroyChipsState extends State<CategroyChips> {
  int selectedIndex = 0;

  @override
  void initState() { 
    super.initState();
    context.read<CategoriesBloc>()..add(GetAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      buildWhen: (previousState, state) => (state is ApiAllCategoriesResult || state is CategoriesInitial),
      builder: (context, state) {
         Widget retVal  = CategoryChipsShimmer();
        if (state is CategoriesInitial) retVal = CategoryChipsShimmer();
        else if (state is ApiAllCategoriesResult) {
          if (state.isSuccess) retVal = _buildCategoryRow(context, state);
          else retVal = Text(state.data.toString());
        } 
        // else if (state is ApiError) {
        //   if (state.error is RangeError) {
        //     return VoidSpacing;
        //   }
        //   retVal = Text(state.error.toString());
        // }
        return retVal;
      },
    );
  }

  Widget _buildCategoryRow(BuildContext context, ApiAllCategoriesResult state) {
    return SizedBox(
      height: ScreenCredentials.screenHeight(context) * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ((state.data?.length ?? 21) <= 20) ? state.data?.length : 20, // 5
        itemBuilder: (BuildContext context, int index) {
          final _chipSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
            child: ChoiceChip(
              labelPadding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
              elevation: 3.0,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: _chipSelected ? Palette.KWhiteClr : Palette.KBlackClr),
                  const SizedBox(width: KSmallPadd),
                  Text(state.data![index + 4].categoryName)
                ],
              ),
              selected: _chipSelected,
              onSelected: (bool value) {
                BlocProvider.of<ProductByCategoryIdBloc>(context).add(GetProductsByCategoryIdEvent(categoryId: state.data![index + 4].apiCategoryId)); 
                print("$index:  ${state.data![index + 4].apiCategoryId}");
                setState(() {selectedIndex = index;},);
              },
              backgroundColor: Theme.of(context).primaryColor,
              selectedColor: Theme.of(context).accentColor,
              labelStyle: TextStyle(color: _chipSelected ? Palette.KWhiteClr : Palette.KBlackClr, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
