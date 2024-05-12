import 'package:e_commerce/constant/font_size.dart';
import 'package:e_commerce/features/home/presentation/components/accessory_list_view_product.dart';
import 'package:e_commerce/features/home/presentation/controllers/Accessories/accessory_state.dart';
import 'package:e_commerce/features/home/presentation/controllers/fav_accessory/fav_accessory_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../models/accessor_model.dart';

import '../../../detailsProduct/presentation/components/accessory_details.dart';
import '../controllers/Accessories/accessory_cubit.dart';
import '../controllers/accessory/acessory_details_cubit.dart';

class SparePieceScreen extends StatefulWidget {
  SparePieceScreen({super.key});

  @override
  State<SparePieceScreen> createState() => _SparePieceScreenState();
}

class _SparePieceScreenState extends State<SparePieceScreen> {
  bool isSelected = false;
  List<AccessoryModel>? products;
  final FavApi favApi = FavApi();
  List<String> errors = [];
  bool isAddingAccessory = false;
  final cartApi = CartApi();

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<AccessoryCubit, AccessoryState>(
        builder: (BuildContext context, state) {
          if (state is AccessoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccessorySuccess) {
            products =   BlocProvider.of<AccessoryCubit>(context).products;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
              child: Container(
                  color: Colors.white,
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:6,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            BlocProvider.of<AccessoryDetailsCubit>(context).getAccessoryDetails(
                              id: products![index].id,
                            );
                            BlocProvider.of<FavAccessoryCubit>(context).isFav(
                              id: products![index].id,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccessoryDetails(
                                      id: products![index].id,
                                    ))).then((_) => setState(() {}));
                          },
                          child: AccessoryListViewProduct(product:  BlocProvider.of<AccessoryCubit>(context).products?[index]));
                    },
                  )),
            );
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
