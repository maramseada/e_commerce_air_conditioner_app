
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../../data/dataSource/orders_data_source.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {

  OrdersApi api;
  late List<OrderModel> orders;
  late List<OrderModel> ordersCompleted;
late   OrderModel order;
  OrdersCubit(this.api) : super(OrdersInitial());



  void getCurrentOrders()async{
    emit(OrdersLoading());
    try{
      orders = await api.ordersCurrent();
      emit(OrdersSuccess(orders: orders));
    }on Exception catch (e){
      emit(OrdersFailure(errMessage: 'error: $e'));
    }
  }  void getExpiredOrders()async{
    emit(OrdersLoading());
    try{
      ordersCompleted = await api.ordersCompleted();
      emit(OrdersSuccess(orders: ordersCompleted));
    }on Exception catch (e){
      emit(OrdersFailure(errMessage: 'error: $e'));
    }
  }
  void getOrderDetails({required int id })async{
    emit(OrdersLoading());
    try{
      order = await api.ordersDetails(id);
      emit(OrdersSuccess(order: order));
    }on Exception catch (e){
      emit(OrdersFailure(errMessage: 'error: $e'));
    }
  }

}

