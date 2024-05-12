
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../models/favourite_product_model.dart';
import 'fav_accessory_state.dart';

class FavAccessoryCubit extends Cubit<FavAccessoryState> {
  Api? api;
  FavApi? favApi;

  FavouriteProductModel? isFavProduct;
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
      isProductFav = await favApi?.isFav(id.toString());

      emit(FavAccessorySuccess(product: isProductFav));
    } catch (e) {
      emit(FavAccessoryFailure(errMessage: 'Error favoriting product: $e'));
    }
  }

  void favAccessory({required int id}) async {
    try {
      isFavProduct = await favApi?.favAccessory(id);
      isProductFav = isFavProduct?.status;
      emit(FavAccessorySuccess(product: isProductFav));
    } catch (e) {
      emit(FavAccessoryFailure(errMessage: 'Error favoriting product: $e'));
    }
  }

  void unFavAccessory({required int id}) async {
    try {
      isFavProduct = await favApi?.unFavAccessory(id);
      isProductFav = isFavProduct?.status;

      emit(FavAccessorySuccess(product: isProductFav));
    } on Exception catch (e, stackTrace) {
      emit(FavAccessoryFailure(errMessage: 'error: $e'));
      print('$e, $stackTrace');
    }
  }
}
