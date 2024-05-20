
import 'package:e_commerce/features/home/data/dataSource/home_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../api/api.dart';
import '../../../../../../models/homeModel.dart';
import 'carousel_home_state.dart';

class CarouselHomeCubit extends Cubit<CarouselHomeState> {
  HomeDataSource api;
  late List<BannerModel>? carouselHome;

  CarouselHomeCubit(this.api) : super(CarouselHomeInitial());



  void getCarouselHome() async {
    emit(CarouselHomeLoading());
    try {
      carouselHome = await api.getBanners();
      emit(CarouselHomeSuccess(carouselHome: carouselHome));
    } on Exception catch (e) {
      emit(CarouselHomeFailure(errMessage: 'error: $e'));
    }
  }



}