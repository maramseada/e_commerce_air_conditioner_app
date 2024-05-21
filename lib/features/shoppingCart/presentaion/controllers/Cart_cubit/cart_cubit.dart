import 'package:e_commerce/features/shoppingCart/data/data_source/cart_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartDataSource api;
  late CartModel cart;
  Map<String, dynamic>? update;

  CartCubit(
    this.api,
  ) : super(CartInitial());

  void getCart() async {
    emit(CartLoading());
    try {
      cart = await api.getCart();
      emit(CartSuccess(cart: cart)); // Update with the latest product state
    } on Exception catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      emit(CartFailure(errMessage: 'error cart : $e'));
    }
  }




}
