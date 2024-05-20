import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/ordermodel.dart';
import '../../../../detailsProduct/presentation/components/productDetails.dart';
import '../../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/product/product_details_cubit.dart';
import '../../controllers/best_sellers/best_sellers_cubit.dart';
import '../../controllers/best_sellers/best_sellers_state.dart';
import 'best_Sellers_home_body.dart';

class BestSeller extends StatefulWidget {


  const BestSeller({super.key,});

  @override
  State<BestSeller> createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  List<ProductsModel>? products;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<BestSellersCubit, BestSellersState>(
        builder: (BuildContext context, state) {
          if (state is BestSellersLoading) {
            return const Center(child:SizedBox());
          } else if (state is BestSellersSuccess) {
           products =   BlocProvider.of<BestSellersCubit>(context).products;

            return BestSellersHomeBody(products: products,);
          } else if (state is BestSellersFailure) {
            return const Text('يوجد خطأ في الأتصال في الأنترنت ');
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
