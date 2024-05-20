import 'package:e_commerce/models/ordermodel.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class SearchState {}
class SearchInitial extends SearchState{}
class SearchLoading extends SearchState{}
class SearchSuccess extends SearchState{
final List<ProductsModel> products;
  SearchSuccess({required this.products});
}
class SearchFailure extends SearchState{
 final String errMessage;
  SearchFailure({required this.errMessage});
}
