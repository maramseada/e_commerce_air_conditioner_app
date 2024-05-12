
import 'package:e_commerce/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/ordermodel.dart';

import '../../../../../models/accessor_model.dart';
import '../../../home/presentation/controllers/accessory/acessory_details_cubit.dart';
import '../../../home/presentation/controllers/accessory/acessory_details_state.dart';
import '../screens/accessory_details_body.dart';
import 'favourite_icon_accessory.dart';

class AccessoryDetails extends StatelessWidget {
  final int id;
  const AccessoryDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    AccessoryModel? accessory;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(    centerTitle: true,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text(
          'تفاصيل المنتج',
          style: TextStyle(
            fontSize:getResponsiveFontSize(context, fontSize: 20),
            fontWeight: FontWeight.bold,
            fontFamily: 'Almarai',
          ),
        ),
      
          actions:[
            FavoriteIconAccessoryBloc( id: id,),
          ]
        ),
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
        )),
    );
  }
}
