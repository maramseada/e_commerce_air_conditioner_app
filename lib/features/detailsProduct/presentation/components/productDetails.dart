
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/product/product_details_cubit.dart';
import '../controller/product/product_details_state.dart';
import '../screens/product_details_body.dart';
import 'favourite_icon_product.dart';

class ProductDetails extends StatelessWidget {
  final int id;

  const ProductDetails({
    super.key,
    required this.id,
  });

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
              id: id,
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
                id: id,
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
