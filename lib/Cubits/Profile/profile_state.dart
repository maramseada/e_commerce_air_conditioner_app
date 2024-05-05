
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProfileState {

}
class ProfileInitial extends ProfileState{}
class ProfileLoading extends ProfileState{}
class ProfileSuccess extends ProfileState{}
class ProfileFailure extends ProfileState{
  String errMessage;
  ProfileFailure({required this.errMessage});


}
