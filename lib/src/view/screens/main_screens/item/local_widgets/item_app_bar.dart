import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/database_bloc/database_bloc.dart';
import 'package:gooloads/src/models/favourite_product_model.dart';
import 'package:gooloads/src/providers/screen_closing_provider.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_appbar_action_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart' as uuid;
import 'package:animate_do/animate_do.dart' as animatedo;


class ItemAppBar extends StatefulWidget {
  final String productId;
  const ItemAppBar({Key? key, required this.productId}) : super(key: key);

  @override
  _ItemAppBarState createState() => _ItemAppBarState();
}

class _ItemAppBarState extends State<ItemAppBar> {
  bool _isHearted = false;

  @override
  void initState() {
    super.initState();
    checkIfProductIsHearted();
  }

  void checkIfProductIsHearted() async {
    final _userCollection = FirebaseFirestore.instance.collection(KUserCollection);
    final _authUser = serviceLocator<AuthService>().getUserCredentials()?.uid??'';
    QuerySnapshot query = await _userCollection.doc(_authUser).collection(KFavouritesCollection)
    .where('productId', isEqualTo: this.widget.productId).get();
    setState.call(()=>_isHearted = query.docs.length == 1);  
  }

  @override
  Widget build(BuildContext context) {
    final screenClosingProvider = Provider.of<ScreenClosingProvider>(context);
    final _userCollection = FirebaseFirestore.instance.collection(KUserCollection);
    final _authUser = serviceLocator<AuthService>().getUserCredentials()?.uid??'';
    return AppBar(
      leading: !screenClosingProvider.getMoreDetailsSectionClosed      
      ? animatedo.FadeInLeft(child: Padding(padding: const EdgeInsets.symmetric(horizontal: KSmallPadd, vertical: KSmallPadd),
          child: MyAppbarActionBtn(icon: Icons.close, onPressed: () => screenClosingProvider.toggleMoreDetailsSectionClosed())))
      : ReusedWidgets.popButton(context),
      actions: [animatedo.FadeInRight(child: Padding(padding: const EdgeInsets.symmetric(horizontal: KSmallPadd),
              child: MyAppbarActionBtn(icon: _isHearted ? Icons.favorite : Icons.favorite_outline,
                wrapForAppBarSizing: true,
                onPressed: () async {
                  QuerySnapshot query = await _userCollection.doc(_authUser).collection(KFavouritesCollection)
                  .where('productId', isEqualTo: this.widget.productId).get();
                  final bool isHearted = query.docs.length == 1;
                  if (!isHearted) {
                    context.read<DatabaseBloc>().add(SaveFavouriteProductEvent(
                      favProduct: FavouriteProduct(
                          favouriteProductId: uuid.Uuid().v1(),
                          productId: this.widget.productId,
                          owner: _authUser,
                          isHearted: true
                        )));
                    setState(() {_isHearted = true;});
                  } else {
                    try{
                      final data = query.docs.first.data() as Map;
                      if(data.isNotEmpty) serviceLocator<DataBaseService>().deleteFavouriteProductFromDB(data['favouriteProductId']);
                      else print("data is null");                    
                    }catch(e){print(e);}
                  setState(() {_isHearted = false;});
                  }
                },
              )),
        )
      ],
    );
  }
}
