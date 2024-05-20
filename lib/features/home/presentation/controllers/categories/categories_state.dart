import 'package:flutter/cupertino.dart';

import '../../../../../models/ordermodel.dart';

@immutable
abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}
class CategoriesInitial extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
 final List<ProductsModel>? products;
  CategoriesSuccess({required this.products});
}

class CategoriesFailure extends CategoriesState {
  final String errMessage;
  CategoriesFailure({required this.errMessage});
}
