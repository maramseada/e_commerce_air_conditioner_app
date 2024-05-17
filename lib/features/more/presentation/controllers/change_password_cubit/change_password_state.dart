
import 'package:flutter/cupertino.dart';

@immutable
abstract class ChangePasswordState {

}
class ChangePasswordInitial extends ChangePasswordState{}
class ChangePasswordLoading extends ChangePasswordState{}
class ChangePasswordSuccess extends ChangePasswordState{}
class ChangePasswordFailure extends ChangePasswordState{
  String errMessage;
  ChangePasswordFailure({required this.errMessage});


}
