import 'package:e_commerce/features/screens/detailsProduct/presentation/controller/product/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../models/favourite_product_model.dart';
import '../../../../../models/ordermodel.dart';
import '../../../../home/presentation/controllers/best_sellers/best_sellers_cubit.dart';

class FavProductDetailsCubit extends Cubit<FavProductDetailsState> {
  Api? api;
  FavApi? favApi;

  FavouriteProductModel? isFavProduct;
  bool? isProductFav;
  BestSellersCubit? bestSellersCubit; // Create an instance of BestSellersCubit

  FavProductDetailsCubit({ this.api,  this.favApi, this.bestSellersCubit}) : super(FavProductDetailsInitial());

  void loadInitialData() async {
    emit(FavProductDetailsLoading());
    try {

      emit(FavProductDetailsSuccess());
    } catch (e) {
      emit(FavProductDetailsFailure(errMessage: 'Error loading initial data: $e'));
    }
  }
  isFav({required int id}) async {
    emit(FavProductDetailsLoading());
    try {
      isProductFav = await favApi?.isFav(id.toString());
      emit(FavProductDetailsSuccess(product: isProductFav));
    } catch (e) {
      emit(FavProductDetailsFailure(errMessage: 'Error favoriting product: $e'));
    }
  }



  void favProduct({required int id}) async {
    try {
      isFavProduct = await favApi?.FavProduct(id);
      isProductFav = isFavProduct?.status;
      emit(FavProductDetailsSuccess(product: isFavProduct?.status));
    } catch (e) {
      emit(FavProductDetailsFailure(errMessage: 'Error favoriting product: $e'));
    }
  }

  void unFavProduct({required int id}) async {
    try {
      isFavProduct = await favApi?.unFavProduct(id);
      isProductFav = isFavProduct?.status;

      emit(FavProductDetailsSuccess(product: isProductFav));
    } on Exception catch (e) {
      emit(FavProductDetailsFailure(errMessage: 'error: $e'));
    }
  }
}
