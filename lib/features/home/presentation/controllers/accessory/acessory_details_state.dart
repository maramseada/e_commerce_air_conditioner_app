
import 'package:flutter/cupertino.dart';

import '../../../../../../models/ordermodel.dart';
import '../../../../../models/accessor_model.dart';

@immutable
abstract class AccessoryDetailsState {

}
class AccessoryDetailsInitial extends AccessoryDetailsState{}
class AccessoryDetailsLoading extends AccessoryDetailsState{}
class AccessoryDetailsSuccess extends AccessoryDetailsState{
  AccessoryModel? product;
  AccessoryDetailsSuccess({required this.product});


}
class AccessoryDetailsFailure extends AccessoryDetailsState{
  String errMessage;
  AccessoryDetailsFailure({required this.errMessage});


}
