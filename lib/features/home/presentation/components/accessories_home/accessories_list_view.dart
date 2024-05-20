import 'package:e_commerce/features/home/presentation/controllers/Accessories/accessory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../models/accessor_model.dart';
import '../../controllers/Accessories/accessory_cubit.dart';
import 'accessories_home_body_bloc.dart';

class SparePieceScreen extends StatelessWidget {
   const SparePieceScreen({super.key});


  @override
  Widget build(BuildContext context) {
    List<AccessoryModel>? products;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<AccessoryCubit, AccessoryState>(
        builder: (BuildContext context, state) {
          if (state is AccessoryLoading) {
            return const Center(child: SizedBox());
          } else if (state is AccessorySuccess) {
            products =   BlocProvider.of<AccessoryCubit>(context).products;

            return AccessoriesHomeBodyBloc(products: products,);
          } else if (state is AccessoryFailure) {
            return const Text('يوجد خطأ في الأتصال في الأنترنت ');
          } else {
            return Container();
          }
        },
      ),

    );
  }
}
