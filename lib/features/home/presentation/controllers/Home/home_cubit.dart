
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../api/api.dart';
import '../../../../../../api/cart_api.dart';
import '../../../../../../api/fav_api.dart';
import '../../../../../../models/favourite_product_model.dart';
import '../../../../../../models/homeModel.dart';
import '../../../data/dataSource/home_data_source.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeDataSource api;
  HomeModel? home;
  HomeCubit(this.api) : super(HomeInitial());



  void getHome() async {
    emit(HomeLoading());
    try {
      home = await api.getHomeData();
      emit(HomeSuccess(home: home));
    } on Exception catch (e) {
      emit(HomeFailure(errMessage: 'error: $e'));
    }
  }


}