import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../models/homeModel.dart';
import '../../../../detailsProduct/presentation/components/productDetails.dart';
import '../../../../detailsProduct/presentation/controller/cart_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/product/product_details_cubit.dart';
import '../../../../detailsProduct/presentation/controller/product/product_details_state.dart';
import '../../controllers/Favourites_cubit/favourites_cubit.dart';

class FavouritesProduct extends StatelessWidget {
  final Product product;
  const FavouritesProduct({super.key , required this.product});

  @override
  Widget build(BuildContext context) {
    late  bool isFavProduct ;

    Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<FavProductDetailsCubit>(context);

    return GestureDetector(
        onTap: () {
          BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
            id: product.id,
          );

          BlocProvider.of<FavProductDetailsCubit>(context).isFav(
            id: product.id,
          );

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    id: product.id,
                  ))).then((_) =>                                  BlocProvider.of<FavouritesCubit>(context).favouriteProducts()
          );
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
              decoration: BoxDecoration(
                color: product.quantity != 0 ? Colors.white : paleGrayColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // Shadow color
                    spreadRadius: 10, // How much the shadow should spread
                    blurRadius: 10, // How soft the shadow should be
                    offset: const Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05), // Shadow color
                            spreadRadius: 1, // How much the shadow should spread
                            blurRadius: 10, // How soft the shadow should be
                            offset: const Offset(0, 5), // Changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: 'https://albakr-ac.com/${product.mainImage}',
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.centerRight,
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getResponsiveFontSize(context, fontSize: 17),
                        fontFamily: 'Almarai',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 18,
                        initialRating: product.totalRate.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: secondColor,
                        ),
                        onRatingUpdate: (rating) {},
                        tapOnlyMode: false,
                      ),
                      const SizedBox(
                          width: 5
                      ),
                      Text(
                        '(${product.totalRate})',
                        style: TextStyle(
                          color: secondColor,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.bold,
                          fontSize: getResponsiveFontSize(context, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${product.price} ر.س ',
                      style: TextStyle(
                          fontSize: getResponsiveFontSize(context, fontSize: 16),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai',
                          color: secondColor),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      product.quantity != 0
                          ? GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartProductDetailsCubit>(context).addToCart(
                            id: product.id.toString(),
                            amount: 1,
                            context: context,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.07), // Shadow color
                                spreadRadius: 1, // How much the shadow should spread
                                blurRadius: 1, // How soft the shadow should be
                                offset: const Offset(1, 1), // Changes position of shadow
                              ),
                            ],
                            border: Border.all(width: 1.0, color: borderButtonColor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  cartIcon
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                'أضف للعربة',
                                style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w700, fontSize: getResponsiveFontSize(context, fontSize: 14), color: kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                      )
                          : Text(
                        'المنتج غير متوفر',
                        style: TextStyle(
                          color: redColor,
                          fontSize: getResponsiveFontSize(context, fontSize: 18),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai',
                        ),
                      ),
                      BlocConsumer<FavProductDetailsCubit, FavProductDetailsState>(
                        builder: (context, state) {
                          if (state is FavProductDetailsLoading) {
                            return SvgPicture.asset('assets/images/favicon.svg', width: 25);
                          } else if (state is FavProductDetailsSuccess) {
                            isFavProduct = product.favorite ?? false;
                            return InkWell(

                              child: isFavProduct
                                  ? SvgPicture.asset('assets/images/favicon.svg', width: 25)
                                  : SvgPicture.asset('assets/images/fav.svg', width: 25),
                              onTap: () {
                                if (isFavProduct == true) {
                                  cubit.unFavProduct(id: product.id);

                                  BlocProvider.of<FavouritesCubit>(context).favouriteProducts();
                                } else {
                                  cubit.favProduct(id: product.id);
                                  BlocProvider.of<FavouritesCubit>(context).favouriteProducts();
                                }
                              },
                            );
                          } else if (state is FavProductDetailsFailure) {
                            return SvgPicture.asset('assets/images/favicon.svg', width: 25);
                          } else {
                            return SvgPicture.asset('assets/images/favicon.svg', width: 25);
                          }
                        },
                        listener: (context, state) {

                            isFavProduct = product.favorite ?? false;

                        },
                      )

                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
