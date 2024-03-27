import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gooloads/src/models/cart_product_dart.dart';
import 'package:gooloads/src/models/favourite_product_model.dart';
import 'package:gooloads/src/models/user_model.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/service_locator.dart';

class DataBaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Create
  // responsible for adding new users to the db
  Future addUserToDB(UserModel userModel) {
    return _db.collection(KUserCollection).doc(userModel.uid).set(userModel.toMap());
  }

  // responsible for adding products to the cart in db
  Future addCartProductToDB(CartProduct cartProduct) {
    return _db.collection(KCartCollection).doc(cartProduct.cartProductId).set(cartProduct.toMap());
  }

  // responsible for adding products to the favourite in db
  Future addFavouriteProductToDB(FavouriteProduct favouriteProduct) {
    return _db.collection(KUserCollection).doc(serviceLocator<AuthService>().getUserCredentials()?.uid)
        .collection(KFavouritesCollection).doc(favouriteProduct.favouriteProductId).set(favouriteProduct.toMap());
  }

  //Read
  // responsible for getting the list of all users from db
  Stream<List<UserModel>> getUsersFromDB() {
    return _db.collection(KUserCollection).snapshots().map(
        (QuerySnapshot snapshot) => snapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  // responsible for getting the list of cart products from db
  Stream<List<CartProduct>> getCartProductsFromDB({bool getAllCarts = false}) {
    return !getAllCarts ? _db.collection(KCartCollection)
            .where('owner', isEqualTo:serviceLocator<AuthService>().getUserCredentials()?.uid)
            .snapshots().map((QuerySnapshot snapshot) => snapshot.docs
              .map((doc) => CartProduct.fromMap(doc.data() as Map<String, dynamic>)).toList())
            : _db.collection(KCartCollection).snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((doc) =>
                    CartProduct.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  // responsible for getting the list of favourite products from db
  Stream<List<FavouriteProduct>> getFavouriteProductsFromDB() {
    return _db.collection(KUserCollection).doc(serviceLocator<AuthService>().getUserCredentials()?.uid)
    .collection(KFavouritesCollection).snapshots().map(
        (QuerySnapshot snapshot) => snapshot.docs
            .map((doc) => FavouriteProduct.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  //Update
  Future updateUserCredsInDB(String uid,
      {required String target, required String replacement}) {
    return _db
        .collection(KUserCollection)
        .doc(uid)
        .update({target: replacement});
  }

  //Delete
  Future<void> deleteUserFromDB(String uid) async {
    return await _db.collection(KUserCollection).doc(uid).delete();
  }

  Future<void> deleteCartProductFromDB(String cartProductId) async {
    return await _db.collection(KCartCollection).doc(cartProductId).delete();
  }

  Future<void> deleteFavouriteProductFromDB(String favouriteProductId) async {
    return await _db.collection(KUserCollection).doc(serviceLocator<AuthService>().getUserCredentials()?.uid)
        .collection(KFavouritesCollection)
        .doc(favouriteProductId)
        .delete();
  }
}
