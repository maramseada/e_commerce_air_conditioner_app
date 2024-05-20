import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../../../detailsProduct/presentation/components/productDetails.dart';
import '../../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/product/product_details_cubit.dart';
import '../../controllers/best_sellers/best_sellers_cubit.dart';
import 'best_sellers_listview_product.dart';

class BestSellersHomeBody extends StatelessWidget {
  final List<ProductsModel>? products;
  const BestSellersHomeBody({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Container(
          color: Colors.white,
          height: 330,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
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
                                ))).then((_) => BlocProvider.of<BestSellersCubit>(context).getBestSellersFav());
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BestSellersListViewProduct(product: BlocProvider.of<BestSellersCubit>(context).products?[index]),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ));
            },
          )),
    );
  }
}
