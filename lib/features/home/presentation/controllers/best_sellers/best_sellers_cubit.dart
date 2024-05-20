import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/ordermodel.dart';

import '../../../data/dataSource/home_data_source.dart';
import 'best_sellers_state.dart';

class BestSellersCubit extends Cubit<BestSellersState> {
  HomeDataSource? api;

  List<ProductsModel>? products;
  BestSellersCubit({this.api}) : super(BestSellersInitial());
  void getBestSellers() async {
    emit(BestSellersLoading());
    try {
      products = await api?.getBestSellers();
      emit(BestSellersSuccess(products: products));
    } catch (e, stackTrace) {
      emit(BestSellersFailure(errMessage: '$e  $stackTrace'));
    }
  }

  void getBestSellersFav() async {
    try {
      products = await api?.getBestSellers();
      emit(BestSellersSuccess(products: products));
    } catch (e, stackTrace) {
      emit(BestSellersFailure(errMessage: '$e  $stackTrace'));
    }
  }


}
