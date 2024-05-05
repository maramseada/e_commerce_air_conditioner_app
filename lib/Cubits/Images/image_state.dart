
import 'package:flutter/cupertino.dart';

@immutable
abstract class ImagesState {}
class ImagesInitial extends ImagesState{}
class ImagesLoading extends ImagesState{}
class ImagesSuccess extends ImagesState {
  final Widget imageWidget;

  ImagesSuccess(this.imageWidget);
}

class ImagesFailure extends ImagesState{
  String errMessage;
  ImagesFailure({required this.errMessage});}