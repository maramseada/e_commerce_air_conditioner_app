import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../models/favourite_product_model.dart';
import '../../../../../models/ordermodel.dart';

class FavProductDetailsCubit extends Cubit<FavProductDetailsState> {
  Api api;
  FavApi favApi;

  FavouriteProductModel? isFavProduct;
  bool isProductFav = false;

  FavProductDetailsCubit(this.api, this.favApi, ) : super(FavProductDetailsInitial());



  void isFav({required int id })async{
    emit(FavProductDetailsLoading());
    try{
      isProductFav =  await favApi.isFav(id.toString());
      emit(FavProductDetailsSuccess(product: isProductFav));
    }catch(e){
      emit(FavProductDetailsFailure(errMessage:'Error favoriting product: $e'));
    }
  }
  void favProduct({required int id}) async {
    emit(FavProductDetailsLoading());
    try {
      isFavProduct = await favApi.FavProduct(id);

      emit(FavProductDetailsSuccess(product: isFavProduct?.status)); // Update with the latest product state
    } catch (e) {

      emit(FavProductDetailsFailure(errMessage: 'Error favoriting product: $e'));
    }
  }

  void unFavProduct({required int id}) async {
    emit(FavProductDetailsLoading());
    try {
      isFavProduct = await favApi.unFavProduct(id);
      // product = await api.productDetails(id: id);
      emit(FavProductDetailsSuccess(product: isProductFav)); // Update with the latest product state
    } on Exception catch (e) {
      emit(FavProductDetailsFailure(errMessage: 'error: $e'));
    }
  }


}
