import 'package:e_commerce/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../api/api.dart';
import '../../../../../constant/colors.dart';
import '../../../../../models/ordermodel.dart';

import '../../../screens/detailsProduct/presentation/controller/cart_product_cubit.dart';
import '../../../screens/detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../screens/detailsProduct/presentation/controller/product/product_details_state.dart';
import '../controllers/best_sellers/best_sellers_cubit.dart';
import 'favourite_icon_list_view.dart';

class BestSellersProduct extends StatefulWidget {
  final ProductsModel? product;
  final bool isFavProduct; // Accept favorite status as a parameter
  BestSellersProduct({Key? key, required this.product, required this.isFavProduct}) : super(key: key);

  @override
  State<BestSellersProduct> createState() => _BestSellersProductState();
}

class _BestSellersProductState extends State<BestSellersProduct> {
  Api api = Api();
  bool isFavProduct = false ;
  @override
  void initState() {
    isFavProduct = widget.product!.favorite?? false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<FavProductDetailsCubit>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: widget.product!.quantity != 0 ? Colors.white : paleGrayColor,
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
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05), // Shadow color
                  spreadRadius: 1, // How much the shadow should spread
                  blurRadius: 10, // How soft the shadow should be
                  offset: const Offset(0, 5), // Changes position of shadow
                ),
              ],
            ),
            child: FutureBuilder<Widget>(
                future: api.ImageHome(widget.product!.image),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final imageWidget = snapshot.data;
                    return imageWidget != null
                        ? SizedBox(
                            child: imageWidget,
                          )
                        : const SizedBox(); //
                  }
                }),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.only(top: size.height * 0.01),
            alignment: Alignment.centerRight,
            child: Text(
              widget.product!.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.04,
                fontFamily: 'Almarai',
              ),
            ),
          ),
          widget.product!.brand != null
              ? SizedBox(
                  //   width: size.width * 0.2,
                  height: 30,
                  child: FutureBuilder<Widget>(
                    future: api.ImageHome(widget.product!.brand!.image),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final imageWidget = snapshot.data;
                        return imageWidget != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align the row to the end (right)
                                children: [
                                  imageWidget,
                                ],
                              )
                            : const SizedBox(); //
                      }
                    },
                  ),
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
                width: size.width * 0.03,
              ),
              Text(
                '(${widget.product!.totalRate})',
                style: TextStyle(
                  color: const Color(0xFFD3A100),
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04,
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
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',
                color: const Color(0xFFCA7009),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(0),
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
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric( vertical: 8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.07), // Shadow color
                                  spreadRadius: 1, // How much the shadow should spread
                                  blurRadius: 1, // How soft the shadow should be
                                  offset: const Offset(1, 1), // Changes position of shadow
                                ),
                              ],
                              border: Border.all(width: 1.0, color: const Color(0x3D1D75B1)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/shopping-cart.svg',
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                 Text(
                                  'أضف للعربة',
                                  style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w700, fontSize: getResponsiveFontSize(context, fontSize: 14), color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                    )
                    : Text(
                        'المنتج غير متوفر',
                        style: TextStyle(
                          color: redColor,
                          fontSize: size.width * 0.043,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai',
                        ),
                      ),

                BlocConsumer<FavProductDetailsCubit, FavProductDetailsState>(
                  builder: (context, state) {
                    if (state is FavProductDetailsLoading) {
                      // Show a loading indicator
                      return SizedBox();
                    } else if (state is FavProductDetailsSuccess) {
                      // Access the success state and build your UI accordingly
                  //    final isFavProduct = cubit.isProductFav ?? false;

                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<BestSellersCubit>(context).getBestSellersFav();

                          if (isFavProduct) {

                            cubit.unFavProduct(id: widget.product!.id);

                          } else {
                            cubit.favProduct(id: widget.product!.id);

                          }
                        },
                        icon: isFavProduct
                            ? SvgPicture.asset('assets/images/favicon.svg', width: 25)
                            : SvgPicture.asset('assets/images/fav.svg', width: 25),
                      );
                    } else if (state is FavProductDetailsFailure) {
                      // Handle the failure state
                      return  SvgPicture.asset('assets/images/favicon.svg', width: 25);
                    } else {
//todo see the sizzee
return  SvgPicture.asset('assets/images/favicon.svg', width: 25);
                    }
                  },
                  listener: (context, state) {
                     isFavProduct =  widget.product!.favorite?? false;

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


