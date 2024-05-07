import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../api/api.dart';
import '../../../../../../api/cart_api.dart';
import '../../../../../../api/fav_api.dart';
import '../../../../../../models/ordermodel.dart';
import 'best_sellers_state.dart';

class BestSellersCubit extends Cubit<BestSellersState>{
  Api? api;

  List<ProductsModel>? products;
  BestSellersCubit({ this.api}) :super(BestSellersInitial());
  void getBestSellers()async{

    emit( BestSellersLoading());
    try{
      products = await api?.getBestSellers();
      emit(BestSellersSuccess(products: products));
    }catch(e, stackTrace){
      emit( BestSellersFailure(errMessage: '$e  $stackTrace'));
    }
  }
  void getBestSellersFav()async{

    try{
      products = await api?.getBestSellers();
      emit(BestSellersSuccess(products: products));
    }catch(e, stackTrace){
      emit( BestSellersFailure(errMessage: '$e  $stackTrace'));
    }
  }
}