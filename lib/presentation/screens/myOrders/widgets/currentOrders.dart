import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../api/orders_api.dart';
import '../../../../models/ordermodel.dart';
import 'emptyOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../api/orders_api.dart';
import '../../../../models/ordermodel.dart';
import 'emptyOrders.dart';
import 'order.dart';

class CurrentOrders extends StatefulWidget {
  CurrentOrders({
    Key? key,
    required this.onNextStep,

    required this.formKey,
  }) : super(key: key);

  final VoidCallback onNextStep;
  final formKey;

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  final _api = OrdersApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<OrderModel>>(
        future: _api.ordersCurrent(),
        builder: (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<OrderModel> orders = snapshot.data!;
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
              return EmptyOrders(); // Assuming EmptyOrders is a widget or a function returning a widget
            }
          } else {
            // Handle case when future hasn't resolved yet
            return Center(
              child: CircularProgressIndicator(), // or any other loading indicator
            );
          }
        },
      ),
    );
  }
}
