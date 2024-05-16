import 'package:e_commerce/features/more/presentation/controllers/orders_cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../controllers/orders_cubit/orders_state.dart';
import '../../screens/my_orders_screens/emptyOrders.dart';
import 'order.dart';

class ExpiredOrders extends StatefulWidget {
  ExpiredOrders({
    Key? key,
    required this.onBackStep,
    this.formKey,
  }) : super(key: key);
  final VoidCallback onBackStep;
  final formKey;
  @override
  State<ExpiredOrders> createState() => _ExpiredOrdersState();
}

class _ExpiredOrdersState extends State<ExpiredOrders> {
  @override
  void initState() {
    BlocProvider.of<OrdersCubit>(context).getExpiredOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(builder: (BuildContext context, state) {
      if (state is OrdersLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is OrdersSuccess) {
        late List<OrderModel> orders;
        orders = BlocProvider.of<OrdersCubit>(context).ordersCompleted;
        print(orders);
        if (orders.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 200),
              child: Column(
                children: List.generate(
                  orders.length,
                  (index) => Order(orderItem: orders[index]), // Assuming Order is a widget or a function returning a widget
                ),
              ),
            ),
          );
        } else {
          return const EmptyOrders();
        }
      } else {
        return const SizedBox();
      }
    });
  }
}
