
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../api/api.dart';
import '../../../../../../models/homeModel.dart';
import 'carousel_home_state.dart';

class CarouselHomeCubit extends Cubit<CarouselHomeState> {
  Api api;
  late List<BannerModel> carouselHome;

  CarouselHomeCubit(this.api) : super(CarouselHomeInitial());



  void getCarouselHome() async {
    emit(CarouselHomeLoading());
    try {
      carouselHome = await api.banners();
      emit(CarouselHomeSuccess(carouselHome: carouselHome));
    } on Exception catch (e) {
      emit(CarouselHomeFailure(errMessage: 'error: $e'));
    }
  }



}