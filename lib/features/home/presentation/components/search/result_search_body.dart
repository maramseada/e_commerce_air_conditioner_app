import 'package:e_commerce/features/home/presentation/components/search/result_search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../models/ordermodel.dart';
import '../../../../detailsProduct/presentation/components/productDetails.dart';
import '../../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/product/product_details_cubit.dart';

class ResultSearchBody extends StatefulWidget {
  final String searchQuery;
  final List<ProductsModel> products;
  const ResultSearchBody({super.key, required this.searchQuery, required this.products});

  @override
  State<ResultSearchBody> createState() => _ResultSearchBodyState();
}

class _ResultSearchBodyState extends State<ResultSearchBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              searchGray,
              width: size.width * 0.08,
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              widget.searchQuery,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.04,
                color: const Color(0xff25170B),
              ),
            ),
          ]),
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
                childAspectRatio: 0.59,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
                        id: widget.products[index].id,
                      );

                      BlocProvider.of<FavProductDetailsCubit>(context).isFav(
                        id: widget.products[index].id,
                      );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                    id: widget.products[index].id,
                                  ))).then((_) => setState(() {}));
                    },
                    child: ResultSearchProduct(
                      product: widget.products[index],
                    ));
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
