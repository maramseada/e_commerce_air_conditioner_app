
import 'package:flutter/cupertino.dart';

@immutable

abstract class FavAccessoryState {

}

class FavAccessoryInitial extends FavAccessoryState{}
class FavAccessoryLoading extends FavAccessoryState{}
class FavAccessorySuccess extends FavAccessoryState{
  bool? product;
  FavAccessorySuccess({ this.product});
}
class FavAccessoryFailure extends FavAccessoryState{
  String errMessage;
  FavAccessoryFailure({required this.errMessage});
}
