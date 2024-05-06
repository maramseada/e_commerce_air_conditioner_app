import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/product_details_cubit.dart';
import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/product_details_state.dart';
import 'package:e_commerce/presentation/screens/detailsProduct/presentation/screens/product_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite_icon_product.dart';

class ProductDetails extends StatefulWidget {
  final int id;

  const ProductDetails({
    super.key,
    required this.id,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late bool isFavProduct;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'تفاصيل المنتج',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Almarai',
            ),
          ),
          actions: [
            FavoriteIconBloc(
              id: widget.id,
            )
          ],
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (BuildContext context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator()); // Show loading indicator
            } else if (state is ProductDetailsSuccess) {
              final product = state.product;
              return ProductDetailsBody(
                product: product,
                id: widget.id,
              );
            } else {
              return const Center(
                child: Text('يوجد خطأ في الأتصال بالأنترنت'),
              );
            }
          },
        ),
      ),
    );
  }
}
