
import 'package:flutter/cupertino.dart';

import '../../../../../models/ordermodel.dart';

@immutable
abstract class OrdersState {

}
class OrdersInitial extends OrdersState{}
class OrdersLoading extends OrdersState{}
class OrdersSuccess extends OrdersState{
  final List<OrderModel>? orders;
  OrderModel? order;
  OrdersSuccess({
     this.orders
    ,this.order
});

}
class OrdersFailure extends OrdersState{
  final String errMessage;
  OrdersFailure({required this.errMessage});


}
