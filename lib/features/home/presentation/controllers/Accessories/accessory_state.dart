
import 'package:flutter/cupertino.dart';

import '../../../../../models/accessor_model.dart';

@immutable
abstract class AccessoryState {

}


class AccessoryInitial extends AccessoryState{}
class AccessoryLoading extends AccessoryState{}
class AccessorySuccess extends AccessoryState{
  List<AccessoryModel>? products;
  AccessorySuccess({ this.products});


}
class AccessoryFailure extends AccessoryState{
  String errMessage;
  AccessoryFailure({required this.errMessage});


}
