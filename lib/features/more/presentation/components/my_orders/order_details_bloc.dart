import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../controllers/orders_cubit/orders_cubit.dart';
import '../../controllers/orders_cubit/orders_state.dart';
import 'order_details_body.dart';

class OrderDetailsBloc extends StatefulWidget {
  const OrderDetailsBloc({super.key});

  @override
  State<OrderDetailsBloc> createState() => _OrderDetailsBlocState();
}

class _OrderDetailsBlocState extends State<OrderDetailsBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(builder: (BuildContext context, state) {


      if (state is OrdersLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is OrdersSuccess) {
        OrderModel? order;
        order =     BlocProvider.of<OrdersCubit>(context).order;

        return  OrderDetailsBody(order: order,);

      }else{
        return const SizedBox();
      }
    });
  }
}



