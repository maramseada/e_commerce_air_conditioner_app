import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';

class CartProductDetailsCubit extends Cubit<CartProductDetailsState> {
  Api api;
  CartApi cartApi;
  bool? isProductFav;
  int? addsId;
  CartProductDetailsCubit(this.api, this.cartApi) : super(CartProductDetailsInitial());
  void addToCart({
    required String id,
    required int amount,
  }) async {
    emit(CartProductDetailsLoading());
    try {
      await cartApi.addProduct(itemId: id, quantity: amount.toString(), addId: addsId.toString());
      emit(CartProductDetailsSuccess()); // Update with the latest product state
    } on Exception catch (e) {
      emit(CartProductDetailsFailure(errMessage: 'error cart : $e'));
    }
  }

}