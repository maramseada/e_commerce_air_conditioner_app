import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/ordermodel.dart';

import '../../../screens/detailsProduct/presentation/components/productDetails.dart';
import '../../../screens/detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../screens/detailsProduct/presentation/controller/product/product_details_cubit.dart';
import '../controllers/fav_products_list/fav_products_list_cubit.dart';
import '../screens/show_bestsellers.dart';
import 'best_Sellers_product.dart';

class BestSellersBody extends StatefulWidget {
  final List<ProductsModel>? products;
  const BestSellersBody({super.key, required this.products});

  @override
  State<BestSellersBody> createState() => _BestSellersBodyState();
}

class _BestSellersBodyState extends State<BestSellersBody> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
          ),
          itemCount: products!.length,
          itemBuilder: (context, index) {
            // print('lengthhhhhh${products!.length}');
            // BlocProvider.of<FavProductDetailsListCubit>(context).isFavProductList?.add(products![index].favorite!);
            //
            // BlocProvider.of<FavProductDetailsListCubit>(context).isFav(
            //    favList: products![index].favorite!,
            // );
            // print('yallahhwyy${BlocProvider.of<FavProductDetailsListCubit>(context).isFavProductList}');

            return GestureDetector(
                onTap: () {
                  BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
                    id: products![index].id,
                  );

                  BlocProvider.of<FavProductDetailsCubit>(context).isFav(
                    id: products![index].id,
                  );

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetails(
                                id: products![index].id,
                              ))).then((_) => setState(() {}));
                },
                child: BestSellersProduct(
                  product: widget.products![index], isFavProduct: widget.products![index].favorite!,
                ));
          },
        ),
      ),
    ));
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
