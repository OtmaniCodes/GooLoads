import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/api_bloc/best_products_bloc/best_products_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/shimmer_widgets/home/best_products_list_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'best_product_list_tile.dart';

class CollapsedBestProductsList extends StatefulWidget {
  const CollapsedBestProductsList({Key? key}) : super(key: key);

  @override
  _CollapsedBestProductsListState createState() =>
      _CollapsedBestProductsListState();
}

class _CollapsedBestProductsListState extends State<CollapsedBestProductsList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Builder(builder: (BuildContext context) {
            return BlocBuilder<BestProductsBloc, BestProductsState>(
              buildWhen: (previousState, state) => (state is BestProductsResult || state is BestProductsError),
              builder: (context, state) {
                Widget retVal =  BestProductsListShimmer();
                if (state is BestProductsInitial) {
                  retVal = BestProductsListShimmer();
                }
                 else if (state is BestProductsResult) {
                  if (state.isSuccess) {
                    retVal = _buildBestProductsList(state);
                  } else {
                    retVal = Text("No Success Error");
                  }
                } else if (state is BestProductsError) {
                  retVal = Text("Outer Error: ${state.error}");
                }
                return retVal;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildBestProductsList(BestProductsResult state) {
    return Expanded(
      child: Scrollbar(
        child: ListView.separated(
          controller: _scrollController,
          itemCount: state.data!.length + 1,
          itemBuilder: (_, index) { 
            return index == state.data!.length
                ? Align(alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(KDefaultPadd),
                      child: MyText(
                      txt: "No More Data to Load!",
                      clr: Palette.KBlackClr,
                  ),
                    ))
                : BestProductListTile(product: state.data![index]);
          },
          separatorBuilder: (_, index) {
            return Divider(
              color: Palette.KBlackClr,
              height: KMediumPadd,
            );
          },
        ),
      ),
    );
  }
}
