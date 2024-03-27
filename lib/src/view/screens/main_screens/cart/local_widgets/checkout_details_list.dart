import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_black_button.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

const List<String> detailsLabel = ["SubTotal", "Shipping", "Total"];
class CheckoutDetailsList extends StatelessWidget {
  CheckoutDetailsList({Key? key}) : super(key: key);

  Future<double> _getSubTotalPricing() async {
    final _firestore = FirebaseFirestore.instance;
    final _authUser = serviceLocator<AuthService>().getUserCredentials();
    List<double> _subTotals = [];
    List<Product> _products = [];
    Map<String, dynamic> savedProductsData = {};
    try{
      QuerySnapshot<Map<String, dynamic>> _myCartProductsQuery = await _firestore.collection(KCartCollection).where('owner', isEqualTo: _authUser?.uid).get();
      final docs = _myCartProductsQuery.docs;
      print('docs $docs');
      print( _authUser?.uid);
      for (var doc in docs)
      if(doc.exists) savedProductsData[doc.data()['productId'].toString()] = doc.data()['productsCount'];
      for (var productId in savedProductsData.keys.toList()){
        final List data = await serviceLocator<ApiService>().getProductById(int.parse(productId)); //!Random().nextInt(4));
        print(data);
        if(data.first == 'success') _products.add(data.last);}
      //! uncomment these two lines when the API is working
      _subTotals = [for (MapEntry<String, dynamic> item in savedProductsData.entries)
        item.value * double.tryParse(_products.where((element) => element.productId.toString() == item.key).toList().first.salePrice??'1')];
      //! delete these two lines when the API is working
      //  _subTotals = [for (MapEntry<String, dynamic> item in savedProductsData.entries)
      //   item.value * double.tryParse(_products.where((element) => _products.indexOf(element) == savedProductsData.keys.toList().indexOf(item.key)).toList().first.salePrice??'1')];
    print('=================================================================================');
    print([for(Product p in _products) p.productId]);
    print(savedProductsData);
    print([for(Product p in _products) p.salePrice]);
    print(_subTotals);
    print('=================================================================================');
    }catch(e){
      print('error: $e');
    }
    if(_subTotals.isNotEmpty){
      return _subTotals.reduce((a, b) => a + b);
    }else{
      return 0.0;
    }
  }

  Future<double> _getShippingPricing() async {
    //TODO: fetch shipping price
    final sub = await _getSubTotalPricing();
    return Future.value(sub == 0.0 ?  0.0 : 0.0);
  }

  Future<double> _getTotalPricing() async {
    double subTotal = await _getSubTotalPricing(); 
    double shipping = await _getShippingPricing();
    return subTotal + shipping;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.KWhiteClr,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(KDefaultPadd), topRight: Radius.circular(KDefaultPadd)),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(KAveragePadd),
              child: Column(
                children: [
                  ...List.generate(
                     detailsLabel.length,
                    (index) => FutureBuilder<double>(
                      future: (index == 0) ? _getSubTotalPricing() : (index == 1) ? _getShippingPricing() : _getTotalPricing() ,
                      builder: (context, pricingSnap){
                        final _hasData = pricingSnap.hasData ? pricingSnap.data != null : false;
                        if(_hasData){
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: KAveragePadd),
                            child: getPaymentDetailsRow(detailsLabel[index], pricingSnap.data!.toStringAsFixed(2)),
                          );
                        }else{
                          return Shimmer.fromColors(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: KAveragePadd),
                            child: getPaymentDetailsRow('', ''),
                          ), baseColor: Palette.KWhitishClr, highlightColor: Palette.KWhiteClr);
                        }
                      })
                  ),
                ],
              ),
            ),
            MEDIUM_VSPACING,
            Padding(padding: const EdgeInsets.all(KAveragePadd),
              child: getCheckoutButton(context))
          ],
        ),
      ),
    );
  }

  Widget getPaymentDetailsRow(String detailLabel, String price) {
    return Stack(children: List.generate(3, (index) {
      late String txt;
      late Alignment alignment;
      switch (index) {
        case 0:
          txt = detailLabel;
          alignment = Alignment.centerLeft;
          break;
        case 1:
          txt = ":";
          alignment = Alignment.center;
          break;
        case 2:
          txt = "\$$price";
          alignment = Alignment.centerRight;
          break;
      }
      return Align(
        alignment: alignment,
        child: MyText(
          txt: txt,
          clr: index == 2 ? Palette.KKGreyShade02Clr : Palette.KBlackClr ,
          isBold: index == 0,
          size: 28,
        ),
      );
    }));
  }

  Widget getCheckoutButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: MyBlackButton(
        onPressed: () {
          Navigator.pop(context);
        },
        txt: 'Proceed to checkout',
      ),
    );
  }
}
