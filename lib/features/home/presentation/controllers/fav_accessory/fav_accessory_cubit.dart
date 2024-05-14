
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/favourite_product_model.dart';
import 'fav_accessory_state.dart';

class FavAccessoryCubit extends Cubit<FavAccessoryState> {
  Api? api;
  FavApi? favApi;

  FavouriteAccessoryModel? isFavProduct;
  bool? isProductFav;

  FavAccessoryCubit({ this.api,  this.favApi}) : super(FavAccessoryInitial());

  void loadInitialData() async {
    emit(FavAccessoryLoading());
    try {

      emit(FavAccessorySuccess());
    } catch (e) {
      emit(FavAccessoryFailure(errMessage: 'Error loading initial data: $e'));
    }
  }
  isFav({required int id}) async {
    emit(FavAccessoryLoading());
    try {
      isProductFav = await favApi?.isFavAccessory(id.toString());

      emit(FavAccessorySuccess(product: isProductFav));
    } catch (e) {
      emit(FavAccessoryFailure(errMessage: 'Error favoriting product: $e'));
    }
  }

  void favAccessory({required int id, required BuildContext context}) async {
    try {
      isFavProduct = await favApi?.favAccessory(id);
      isProductFav = isFavProduct?.status;
      emit(FavAccessorySuccess(product: isProductFav));

      SnackBar snackBar = const SnackBar(
        content: Text(
          'تمت اضافة المنتج من المفضلة بنجاح ',
          style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white, // Set your desired background color here
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } catch (e, stackTrace) {
      emit(FavAccessoryFailure(errMessage: 'Error favoriting product: $e trace $stackTrace'));
    }
  }

  void unFavAccessory({required int id, required BuildContext context}) async {
    try {
      isFavProduct = await favApi?.unFavAccessory(id);
      isProductFav = isFavProduct?.status;

      emit(FavAccessorySuccess(product: isProductFav));
      SnackBar snackBar = const SnackBar(
        content: Text(
          'تمت ازالة المنتج من المفضلة بنجاح ',
          style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white, // Set your desired background color here
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on Exception catch (e, stackTrace) {
      emit(FavAccessoryFailure(errMessage: 'Error favoriting product: $e trace $stackTrace'));
      print('Error favoriting product $e,trace  $stackTrace');
    }
  }
}
