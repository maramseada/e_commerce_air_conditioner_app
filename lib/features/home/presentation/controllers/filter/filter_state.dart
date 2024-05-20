import 'package:flutter/cupertino.dart';

import '../../../../../models/brandModel.dart';
import '../../../../../models/ordermodel.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterSuccess extends FilterState {
  final List<ProductsModel>? products;

  FilterSuccess({ this.products});
}

class FilterFailure extends FilterState {
  String errMessage;
  FilterFailure({required this.errMessage});
}
