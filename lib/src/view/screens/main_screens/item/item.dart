import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/api_bloc/product_by_id_bloc/product_by_id_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/view/screens/main_screens/item/local_widgets/item_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/view/shimmer_widgets/item/item_content_shimmer.dart';
import 'local_widgets/add_product_to_cart_button.dart';
import 'local_widgets/categories_row.dart';
import 'local_widgets/more_details_section.dart';
import 'local_widgets/product_title.dart';
import 'local_widgets/swipeable_product_images.dart';
import 'package:provider/provider.dart';


class ItemScreen extends StatefulWidget {
  final int productId;
  const ItemScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ProductByIdBloc>().add(GetProductByIdEvent(productId: this.widget.productId));
  }

  bool _buildCondition(ProductByIdState state) => (state is APiProductByIdResult || state is ProductByIdInitial || state is ProductByIdError);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(56),
        child: ItemAppBar(productId: this.widget.productId.toString())),
      body: BlocBuilder<ProductByIdBloc, ProductByIdState>(
        buildWhen: (prevState, newState) => _buildCondition(newState),
        builder: (context, state) {
          if (state is APiProductByIdResult) return _buildItemContent(state);
          else if (state is ProductByIdError) {return Text("ERROR: ${state.error}");}
          else return ItemContentShimmer();        
        },
      ),
    );
  }

  Widget _buildItemContent(APiProductByIdResult state) {
    return Stack(children: [Column(children: 
            [MEDIUM_VSPACING,
            SwipeableProductImages(images: state.data!.productSmallImageUrls!),
            MEDIUM_VSPACING,
            CategoriesRow(categoriesNames: state.data!.productCategoriesBreadcrumb?.map((map) => map["name"]).toList()),
            Padding(padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
              child: AddProductToCartButton(productId: this.widget.productId.toString())),
            // ProductTitle(title: state.data!.productTitle!),
            MEDIUM_VSPACING,
          ],
        ),
        Align(alignment: Alignment.bottomCenter,
          child: MoreDetailsSection(product: state.data!),
        )
      ],
    );
  }
}
