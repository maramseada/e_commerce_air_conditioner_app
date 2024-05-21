import 'package:e_commerce/features/shoppingCart/presentaion/controllers/update_product/update_product_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_source/cart_data_source.dart';

class CartProductCubit extends Cubit<CartProductState> {
  CartDataSource api;
  Map<String, dynamic>? update;

  CartProductCubit(
    this.api,
  ) : super(CartProductInitial());

  void updateProduct({required int id, required int quantity, required int addId}) async {
    emit(CartProductLoading());
    try {
      update = await api.updateProduct(itemId: id.toString(), quantity: quantity.toString(), addId: addId.toString());
      emit(CartProductSuccess()); // Update with the latest product state
    } on Exception catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      emit(CartProductFailure(errMessage: 'error cart : $e'));
    }
  }
  void updateAccessory({required int id, required int quantity}) async {
    emit(CartProductLoading());
    try {
      update = await api.updateAccessory(itemId: id.toString(), quantity: quantity.toString());
      emit(CartProductSuccess()); // Update with the latest product state
    } on Exception catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      emit(CartProductFailure(errMessage: 'error cart : $e'));
    }
  }
}
