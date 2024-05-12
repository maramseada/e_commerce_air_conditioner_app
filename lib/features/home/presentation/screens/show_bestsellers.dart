import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';

import '../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../components/best_sellers_body.dart';
import '../controllers/best_sellers/best_sellers_cubit.dart';
import '../controllers/best_sellers/best_sellers_state.dart';
import '../../../../widgets/floating_button_ask_price.dart';

class ShowBestSellers extends StatefulWidget {
  final String productName;
  const ShowBestSellers({super.key, required this.productName});

  @override
  State<ShowBestSellers> createState() => _ShowBestSellersState();
}

List<ProductsModel>? products;

class _ShowBestSellersState extends State<ShowBestSellers> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            widget.productName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(
            color: Colors.blue,
          ),
        ),
        body: BlocConsumer<BestSellersCubit, BestSellersState>(
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
        ),
        floatingActionButton: const AskPriceFloatingButton(),
      ),
    );
  }
}

