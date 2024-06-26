import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../api/api.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/ordermodel.dart';

import '../../../../../widgets/add_to_cart_button.dart';
import '../../../../detailsProduct/presentation/controller/cart_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../../detailsProduct/presentation/controller/product/product_details_state.dart';
import '../../controllers/best_sellers/best_sellers_cubit.dart';

class BestSellersProduct extends StatefulWidget {
  final ProductsModel? product;
  const BestSellersProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<BestSellersProduct> createState() => _BestSellersProductState();
}

class _BestSellersProductState extends State<BestSellersProduct> {
  Api api = Api();
  late bool isFavProduct;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<FavProductDetailsCubit>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: widget.product!.quantity != 0 ? Colors.white : paleGrayColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CachedNetworkImage(imageUrl: 'https://albakr-ac.com/${widget.product!.image}')),
          Container(
            height: 60,
            padding: const EdgeInsets.only(top: 8),
            alignment: Alignment.centerRight,
            child: Text(
              widget.product!.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveFontSize(context, fontSize: 18),
                fontFamily: 'Almarai',
              ),
            ),
          ),
          widget.product!.brand != null
              ? SizedBox(
                  //   width: size.width * 0.2,
                  height: 30,
                  child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: 'https://albakr-ac.com/${widget.product!.brand!.image}',
              errorWidget: (context, url, error) => const Icon(Icons.access_alarm)),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 20,
                initialRating: widget.product!.totalRate.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const FaIcon(
                  FontAwesomeIcons.solidStar,
                  color: Color(0xFFD3A100),
                ),
                onRatingUpdate: (rating) {},
                tapOnlyMode: false,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text(
                '(${widget.product!.totalRate})',
                style: TextStyle(
                  color: const Color(0xFFD3A100),
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveFontSize(context, fontSize: 20),
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '${widget.product!.price} ر.س ',
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize: 18),
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',
                color: const Color(0xFFCA7009),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.product!.quantity != 0
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<CartProductDetailsCubit>(context).addToCart(
                              id: widget.product!.id.toString(),
                              amount: 1,
                              context: context,
                            );
                          },
                          child: const AddToCartButton(),
                        ),
                      )
                    : Text(
                        'المنتج غير متوفر',
                        style: TextStyle(
                          color: redColor,
                          fontSize: getResponsiveFontSize(context, fontSize: 20),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai',
                        ),
                      ),
                BlocConsumer<FavProductDetailsCubit, FavProductDetailsState>(
                  builder: (context, state) {
                    if (state is FavProductDetailsSuccess) {
                      isFavProduct = widget.product!.favorite ?? false;

                      return InkWell(
                        onTap: () {
                          if (isFavProduct) {
                            cubit.unFavProduct(id: widget.product!.id);
                            BlocProvider.of<BestSellersCubit>(context).getBestSellersFav();
                          } else {
                            cubit.favProduct(id: widget.product!.id);
                            BlocProvider.of<BestSellersCubit>(context).getBestSellersFav();
                          }
                        },
                        child: isFavProduct
                            ? SvgPicture.asset('assets/images/favicon.svg', width: 25)
                            : SvgPicture.asset('assets/images/fav.svg', width: 25),
                      );
                    } else if (state is FavProductDetailsFailure) {
                      return SvgPicture.asset('assets/images/favicon.svg', width: 25);
                    } else {
                      //todo see the sizzee
                      return SvgPicture.asset('assets/images/favicon.svg', width: 25);
                    }
                  },
                  listener: (context, state) {
                    setState(() {
                      isFavProduct = widget.product!.favorite ?? false;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
