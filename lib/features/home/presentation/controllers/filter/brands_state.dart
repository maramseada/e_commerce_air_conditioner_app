import '../../../../../models/brandModel.dart';
import 'package:flutter/cupertino.dart';
@immutable
abstract class BrandsState {}

class BrandsLoading extends BrandsState {}
class BrandsInitial extends BrandsState {}

class BrandsSuccess extends BrandsState {
  List<BrandModel>? brand;

  BrandsSuccess({required this.brand});
}

class BrandsFailure extends BrandsState {
  String errMessage;
  BrandsFailure({required this.errMessage});
}
