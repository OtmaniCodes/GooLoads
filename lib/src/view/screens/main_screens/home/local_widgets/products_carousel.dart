import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gooloads/src/blocs/api_bloc/api_bloc.dart';
import 'package:gooloads/src/blocs/api_bloc/product_by_category_id_bloc/product_by_category_id_bloc.dart';
// import 'package:gooloads/src/blocs/api_bloc/api_bloc.dart';
import 'package:gooloads/src/models/card_product_model.dart';
import 'package:gooloads/src/providers/products_count_provider.dart';
import 'package:gooloads/src/services/animation/elastic_animation.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/shimmer_widgets/home/products_carousel_shimmer.dart';
import 'category_chips.dart';

class ProductsCarousel extends StatefulWidget {
  const ProductsCarousel({Key? key}) : super(key: key);

  @override
  _ProductsCarouselState createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<ProductsCarousel> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
     context.read<ProductByCategoryIdBloc>().add(GetProductsByCategoryIdEvent(categoryId: KInitialProductId));
    _pageController = PageController(
      initialPage: _currentPageIndex,
      viewportFraction: 0.5,
      keepPage: false,
    );
  }

  @override
  void dispose() {
    _currentPageIndex = 0;
    _pageController.dispose();
    super.dispose();
  }
  
  bool buildCondition(ProductByCategoryIdState newState) => (newState is ProductsByCategoryIdResult || newState is ProductByCategoryIdInitial || newState is ProductByCategoryIdError);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 320,
          child: Builder(builder: (BuildContext context) {
              return BlocBuilder<ProductByCategoryIdBloc, ProductByCategoryIdState>(
                // buildWhen: (oldState, newState) => buildCondition(newState),
                builder: (context, state) {
                print(state);
                if (state is ProductsByCategoryIdResult) {
                    return buildCarousel(state);
                  } else if (state is ProductByCategoryIdError) {
                    if (state.error is RangeError) {
                      print(state.error);
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.all(KDefaultPadd),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, size: 30),
                              SMALL_VSPACING,
                              MyText(
                                alignment: TextAlign.center,
                                clr: Palette.KBlackClr,
                                txt:  "Apperantly you've exeeded your requests limit for the day.\nTry again later.",
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(child: Text("probrbly an error: ${state.error.toString()}"));
                  }  else {
                    return ProductsCarouselShimmer();
                  } 
               
                },
              );
            },
          ),
        ),
        CategroyChips()
      ],
    );
  }

  Widget getProductCard(int index, CardProductModel product) {
    return SizedBox(
      child: MyProductCard(product: product),
    );
  }

  Widget buildCarousel(ProductsByCategoryIdResult state) {
    if (state.isSuccess && state.data!.isNotEmpty) {
      return CarouselSlider.builder(
          key: Key('products_carousel'),
          options: CarouselOptions(              
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              disableCenter: true,
              enlargeCenterPage: true,
              initialPage: _currentPageIndex,
              onPageChanged: (newPageIndex, reason) async {
                await HapticFeedback.mediumImpact();
                setState(() => _currentPageIndex = newPageIndex);
              },
              enableInfiniteScroll: false,
              viewportFraction: 0.5),
              itemCount: state.data?.length??0,
              itemBuilder: (context, index, _realIndex) {
            return
                // ElasticInAnimation(
                //   animate: index == _currentPageIndex,
                // child:
              IgnorePointer(
              ignoring: index != _currentPageIndex && state.data!.length > 1,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  context.read<ProductsCountProvider>().setProductsCount = 1;
                  Navigator.pushNamed(context, KItemRoute, arguments: state.data![index].productId);
                },
                child: getProductCard(index, state.data![index])),
              // ),
            );
          });
    } else if (state.isSuccess && state.data!.isEmpty){
      return Center(child: Text("No products available!"));
    }else
      return Center(child: Text("no success"));
  }
}
