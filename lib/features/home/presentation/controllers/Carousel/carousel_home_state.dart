import 'package:flutter/cupertino.dart';

import '../../../../../../models/homeModel.dart';

@immutable
abstract class CarouselHomeState {

}

class CarouselHomeInitial extends CarouselHomeState{}
class CarouselHomeLoading extends CarouselHomeState{}
class CarouselHomeSuccess extends CarouselHomeState{
  List<BannerModel>? carouselHome;
  CarouselHomeSuccess({required this.carouselHome});


}
class CarouselHomeFailure extends CarouselHomeState{
  String errMessage;
  CarouselHomeFailure({required this.errMessage});


}
