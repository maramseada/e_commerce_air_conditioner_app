import 'package:e_commerce/features/detailsProduct/presentation/controller/product/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../constant/colors.dart';

class CartProductDetailsCubit extends Cubit<CartProductDetailsState> {
  Api api;
  CartApi cartApi;
  bool? isProductFav;
  int addsId = 1;
  CartProductDetailsCubit(this.api, this.cartApi) : super(CartProductDetailsInitial());
  void addToCart({
    required String id,
    required int amount,
    required BuildContext context
  }) async {
    emit(CartProductDetailsLoading());
    try {
      await cartApi.addProduct(itemId: id, quantity: amount.toString(), addId: addsId.toString());
      emit(CartProductDetailsSuccess()); // Update with the latest product state
      SnackBar snackBar = const SnackBar(
        content: Text(
          'تمت اضافه المنتج الي عربة التسوق بنجاح ',
          style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white, // Set your desired background color here
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar); } on Exception catch (e) {
      emit(CartProductDetailsFailure(errMessage: 'error cart : $e'));
    }
  }

  void addToCartAccessory({required String id, required int amount, required BuildContext context}) async {
    emit(CartProductDetailsLoading());
    try {
      await cartApi.addAccessory(itemId: id, quantity: amount.toString());
      emit(CartProductDetailsSuccess());
      SnackBar snackBar = const SnackBar(
        content: Text(
          'تمت اضافه المنتج الي عربة التسوق بنجاح ',
          style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white, // Set your desired background color here
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on Exception catch (e) {
      emit(CartProductDetailsFailure(errMessage: 'error cart : $e'));
    }
  }
}
