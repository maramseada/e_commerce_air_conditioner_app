
import 'package:flutter/cupertino.dart';

import '../../../../../../models/homeModel.dart';

@immutable
abstract class HomeState {}
class HomeInitial extends HomeState{}
class HomeLoading extends HomeState{}
class HomeSuccess extends HomeState{
  HomeModel? home;
  HomeSuccess({required this.home});
}
class HomeFailure extends HomeState{
  String errMessage;
  HomeFailure({required this.errMessage});
}
