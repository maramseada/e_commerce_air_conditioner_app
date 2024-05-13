
import 'package:flutter/cupertino.dart';

import '../../data/models/works.dart';

@immutable
abstract class OurWorkState {

}

class OurWorkInitial extends OurWorkState{}
class OurWorkLoading extends OurWorkState{}
class OurWorkDataSuccess extends OurWorkState{
  Map<String, dynamic> data;
  OurWorkDataSuccess({ required this.data});


}
class OurWorkSuccess extends OurWorkState{
  List<Works> work;
  OurWorkSuccess({ required this.work });


}
class OurWorkFailure extends OurWorkState{
  String errMessage;
  OurWorkFailure({required this.errMessage});


}
