
import 'package:flutter/cupertino.dart';

import '../../../../../models/favourite_product_model.dart';
import '../../../../../models/ordermodel.dart';

@immutable
abstract class ProductDetailsState {

}
abstract class FavProductDetailsState {

}abstract class CartProductDetailsState {

}
class ProductDetailsInitial extends ProductDetailsState{}
class ProductDetailsLoading extends ProductDetailsState{}
class ProductDetailsSuccess extends ProductDetailsState{
  ProductsModel? product;
  ProductDetailsSuccess({required this.product});


}
class ProductDetailsFailure extends ProductDetailsState{
  String errMessage;
  ProductDetailsFailure({required this.errMessage});


}
class FavProductDetailsInitial extends FavProductDetailsState{}
class FavProductDetailsLoading extends FavProductDetailsState{}
class FavProductDetailsSuccess extends FavProductDetailsState{
  bool? product;
  FavProductDetailsSuccess({required this.product});
}
class FavProductDetailsFailure extends FavProductDetailsState{
  String errMessage;
  FavProductDetailsFailure({required this.errMessage});
}

class CartProductDetailsInitial extends CartProductDetailsState{}
class CartProductDetailsLoading extends CartProductDetailsState{}
class CartProductDetailsSuccess extends CartProductDetailsState{}
class CartProductDetailsFailure extends CartProductDetailsState{
  String errMessage;
  CartProductDetailsFailure({required this.errMessage});
}