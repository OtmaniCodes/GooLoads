import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:gooloads/src/blocs/api_bloc/api_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/api_bloc/search_products_bloc/search_products_bloc.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/shimmer_widgets/search/search_products_grid_shimmer.dart';
import 'search_product_card.dart';

class SearchProductsList extends StatelessWidget {
  const SearchProductsList({Key? key}) : super(key: key);

  bool _buildCondition(state) => (state is SearchProductsResult || state is SearchProductsError || state is SearchProductsInitial);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchProductsBloc, SearchProductsState>(
      buildWhen: (prevState, newState) => _buildCondition(newState),
      builder: (context, state) {
        if (state is SearchProductsInitial) return SearchProductsGridShimmer();//Center(child: CircularProgressIndicator(color: Palette.KBlackClr));
        else if (state is SearchProductsResult) {return _buildSearchProductsGrid(state);}
        else return Center(child: Text('an error fetching the search screen data...'));
      },
    );
  }

  Widget _buildSearchProductsGrid(SearchProductsResult state) {
    if (state.isSuccess && state.data!.isNotEmpty) return Scrollbar(
      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true, crossAxisCount: 2,
        itemCount: state.data?.length??0,
        itemBuilder: (_, index) => SearchProductCard(product: state.data![index]),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      ),
    ); else return Center(
      child: MyText(
        txt: "Unable to find this desired product.",
        clr: Palette.KBlackClr,
      ),
    );    
  }
}
