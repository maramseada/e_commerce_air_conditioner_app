
import 'package:flutter/cupertino.dart';

import '../../../../../models/cart_model.dart';

@immutable
abstract class CartState {

}

class CartInitial extends CartState{}
class CartLoading extends CartState{}
class CartSuccess extends CartState{
  final CartModel cart;
  CartSuccess({ required this.cart});


}
class CartFailure extends CartState{
  String errMessage;
  CartFailure({required this.errMessage});


}
