import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../components/best_sellers/best_sellers_body.dart';
import '../../controllers/best_sellers/best_sellers_cubit.dart';
import '../../controllers/best_sellers/best_sellers_state.dart';
class BestSellersBodyBloc extends StatefulWidget {
  const BestSellersBodyBloc({super.key});

  @override
  State<BestSellersBodyBloc> createState() => _BestSellersBodyBlocState();
}
List<ProductsModel>? products;

class _BestSellersBodyBlocState extends State<BestSellersBodyBloc> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<BestSellersCubit, BestSellersState>(
      builder: (BuildContext context, state) {
        if (state is BestSellersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BestSellersSuccess) {
          products = BlocProvider.of<BestSellersCubit>(context).products;
          BlocProvider.of<FavProductDetailsCubit>(context).loadInitialData();
          return BestSellersBody(products: products);
        } else if (state is BestSellersFailure) {
          return const Center(child: Text('يوجد مشكلة في الاتصال بالانترنت '));
        } else {
          return const SizedBox();
        }
      },
      listener: (BuildContext context, BestSellersState state) {
        if (state is BestSellersSuccess) {
          products = BlocProvider.of<BestSellersCubit>(context).products;


        }
      },
    );
  }
}
