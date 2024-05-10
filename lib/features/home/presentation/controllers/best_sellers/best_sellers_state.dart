
import 'package:flutter/cupertino.dart';

import '../../../../../../models/ordermodel.dart';

@immutable
abstract class BestSellersState {

}


class BestSellersInitial extends BestSellersState{}
class BestSellersLoading extends BestSellersState{}
class BestSellersSuccess extends BestSellersState{
  List<ProductsModel>? products;
  BestSellersSuccess({ this.products});


}
class BestSellersFailure extends BestSellersState{
  String errMessage;
  BestSellersFailure({required this.errMessage});


}
