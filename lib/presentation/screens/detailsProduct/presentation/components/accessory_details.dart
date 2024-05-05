import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/acessory_details_cubit.dart';
import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/acessory_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/ordermodel.dart';

import '../screens/accessory_details_body.dart';

class AccessoryDetails extends StatelessWidget {
  final int id;
  const AccessoryDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    AccessoryModel? accessory;
    return Scaffold(
      body: BlocConsumer<AccessoryDetailsCubit, AccessoryDetailsState>(builder:  (BuildContext context, state) {
        if (state is AccessoryDetailsLoading){
    return const CircularProgressIndicator();

    }else if (state is AccessoryDetailsSuccess){
          accessory = BlocProvider.of<AccessoryDetailsCubit>(context).product;
          return AccessoryDetailsBody(id: id, Accessory: accessory,);
        }else {
          return const Text('يوجد خطأ في الأتصال بالأنترنت');
        }
  }, listener: (BuildContext context, AccessoryDetailsState state) {
}
      ));
  }
}
