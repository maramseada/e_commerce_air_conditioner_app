import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../models/favourite_product_model.dart';
import '../../../../../models/ordermodel.dart';
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  Api api;
  FavApi favApi;
  CartApi cartApi;
  ProductsModel? product;
  FavouriteProductModel? isFavProduct;
  bool? isProductFav;

  int amount = 1;
  ProductDetailsCubit(this.api, this.favApi, this.cartApi) : super(ProductDetailsInitial());


  void amountIncrease() {
    if (amount < product!.quantity) {
      amount++;
      print('amount$amount');
    }
    emit(ProductDetailsSuccess(product: product)); // Update state with new installation option
  }

  void amountDecrease() {
    if (amount > 1) {
      amount--;
      print('amount$amount');
    }
    emit(ProductDetailsSuccess(product: product)); // Update state with new installation option
  }

  void getProductDetails({required int id}) async {
    emit(ProductDetailsLoading());
    try {
      product = await api.productDetails(id: id);
      emit(ProductDetailsSuccess(product: product));
    } on Exception catch (e) {
      emit(ProductDetailsFailure(errMessage: 'error: $e'));
    }
  }



}