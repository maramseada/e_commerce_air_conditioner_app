
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../api/api.dart';
import '../../../../../../api/cart_api.dart';
import '../../../../../../api/fav_api.dart';
import '../../../../../../models/favourite_product_model.dart';
import '../../../../../../models/homeModel.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Api api;
  FavApi favApi;
  CartApi cartApi;
  HomeModel? home;
  FavouriteProductModel? isFavProduct;
  bool? isProductFav;
  List<Product>? productsBestSellers;
  int amount = 1;
  HomeCubit(this.api, this.favApi, this.cartApi) : super(HomeInitial());



  void getHome() async {
    emit(HomeLoading());
    try {
      home = await api.Home();
      emit(HomeSuccess(home: home));
    } on Exception catch (e) {
      emit(HomeFailure(errMessage: 'error: $e'));
    }
  }
  // void getBestSellersHome() async {
  //   try {
  //     home = await api.Home();
  //     print('omkpmpokok');
  //     productsBestSellers = home?.products;
  //     emit(HomeSuccess(home: home));
  //   } catch (e, stackTrace) {
  //     emit(HomeFailure(errMessage: '$e  $stackTrace'));
  //   }
  // }


}