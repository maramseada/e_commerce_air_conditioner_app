import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/ordermodel.dart';
import '../../../../detailsProduct/presentation/components/productDetails.dart';
import '../../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/product/product_details_cubit.dart';
import 'filtered_product.dart';

class FilteredProductsBody extends StatefulWidget {
  final List<ProductsModel>? products;

  const FilteredProductsBody({super.key, required this.products});

  @override
  State<FilteredProductsBody> createState() => _FilteredProductsBodyState();
}

class _FilteredProductsBodyState extends State<FilteredProductsBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
          child: RefreshIndicator(
        onRefresh: () => _pullRefresh(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.04, right: size.width * 0.04, top: size.height * 0.01),
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.53,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: widget.products?.length,
                  // Set the number of items in the grid
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
                            id: widget.products![index].id,
                          );

                          BlocProvider.of<FavProductDetailsCubit>(context).isFav(
                            id: widget.products![index].id,
                          );

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                        id: widget.products![index].id,
                                      ))).then((_) => setState(() {}));
                        },
                        child: FilteredProduct(product: widget.products?[index]));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
