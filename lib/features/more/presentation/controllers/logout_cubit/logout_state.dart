import 'package:flutter/cupertino.dart';


@immutable
abstract class LogoutState {

}
class LogoutInitial extends LogoutState{}
class LogoutLoading extends LogoutState{}
class LogoutSuccess extends LogoutState{
}
class LogoutFailure extends LogoutState{
  String errMessage;
  LogoutFailure({required this.errMessage});
}
