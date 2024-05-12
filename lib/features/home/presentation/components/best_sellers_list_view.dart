import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/ordermodel.dart';
import '../../../detailsProduct/presentation/components/productDetails.dart';
import '../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../detailsProduct/presentation/controller/product/product_details_cubit.dart';
import '../controllers/best_sellers/best_sellers_cubit.dart';
import '../controllers/best_sellers/best_sellers_state.dart';
import 'best_sellers_listview_product.dart';

class BestSeller extends StatefulWidget {


  const BestSeller({super.key,});

  @override
  State<BestSeller> createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  List<ProductsModel>? products;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<BestSellersCubit, BestSellersState>(
        builder: (BuildContext context, state) {
          if (state is BestSellersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BestSellersSuccess) {
           products =   BlocProvider.of<BestSellersCubit>(context).products;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
              child: Container(
                  color: Colors.white,
                  height: 330,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:6,
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
                                        ))).then((_) => setState(() {}));
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              BestSellersListViewProduct(product:  BlocProvider.of<BestSellersCubit>(context).products?[index]),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ));
                    },
                  )),
            );
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
