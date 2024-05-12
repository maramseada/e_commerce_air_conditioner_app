
import 'package:flutter/cupertino.dart';

import '../../../../../../models/favourite_product_model.dart';
import '../../../../../../models/ordermodel.dart';
import '../../../../../models/fav_model.dart';

@immutable
abstract class FavouritesState {

}
class FavouritesInitial extends FavouritesState{}
class FavouritesLoading extends FavouritesState{}
class FavouritesSuccess extends FavouritesState{
  FavModel? allproducts;
  FavouritesSuccess({  this.allproducts});
}
class FavouritesFailure extends FavouritesState{
  String errMessage;
  FavouritesFailure({required this.errMessage});
}
