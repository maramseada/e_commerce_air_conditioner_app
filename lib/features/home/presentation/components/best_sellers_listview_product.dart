import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../api/api.dart';
import '../../../../core/constant/colors.dart';
import '../../../../widgets/add_to_cart_button.dart';
import '../../../detailsProduct/presentation/controller/cart_product_cubit.dart';
import '../../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../../detailsProduct/presentation/controller/product/product_details_state.dart';
import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter_svg/svg.dart';
import '../controllers/best_sellers/best_sellers_cubit.dart';

class BestSellersListViewProduct extends StatefulWidget {
  final ProductsModel? product;
  const BestSellersListViewProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<BestSellersListViewProduct> createState() => _BestSellersListViewProductState();
}

class _BestSellersListViewProductState extends State<BestSellersListViewProduct> {
  Api api = Api();
 late bool isFavProduct ;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<FavProductDetailsCubit>(context);
    return Container(
      width: size.width * 0.5,
      decoration: BoxDecoration(
        color: widget.product!.quantity != 0 ? Colors.white : paleGrayColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06), // Shadow color
            spreadRadius: 10, // How much the shadow should spread
            blurRadius: 10, // How soft the shadow should be
            offset: const Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(
        right: 10,
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
            child: CachedNetworkImage(imageUrl: 'https://albakr-ac.com/${widget.product!.image}',
                fit: BoxFit.fill,
                errorWidget: (context, url, error)=> const Icon(Icons.access_alarm)
            ),
          ),
          Container(
              height: 60,
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                widget.product!.name,
                textAlign: TextAlign.right,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: getResponsiveFontSize(context, fontSize: 16), fontFamily: 'Almarai'),
              )),
        Container(
alignment: Alignment.centerRight,            height: 30,
          child: CachedNetworkImage(imageUrl: 'https://albakr-ac.com/${widget.product?.brand?.image}',
            //  fit: BoxFit.fill,
              errorWidget: (context, url, error)=> const SizedBox(),
          ),
        ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(top: 5),
            child: (Text(
              '${widget.product!.price} ر.س ',
              style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.bold, fontFamily: 'Almarai', color: const Color(0xFFCA7009)),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.product!.quantity != 0
                  ? GestureDetector(
                      onTap: () {
                        BlocProvider.of<CartProductDetailsCubit>(context).addToCart(
                          id: widget.product!.id.toString(),
                          amount: 1, context: context,
                        );
                      },
                      child: const AddToCartButton(),
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
                    return SvgPicture.asset('assets/images/favicon.svg', width: 27);
                  } else if (state is FavProductDetailsSuccess) {
                    isFavProduct = widget.product!.favorite ?? false;
                    return IconButton(
                      onPressed: () {
                        if (isFavProduct == true) {
                          cubit.unFavProduct(id: widget.product!.id);

                          BlocProvider.of<BestSellersCubit>(context).getBestSellersFav();
                        } else {
                          cubit.favProduct(id: widget.product!.id);
                          BlocProvider.of<BestSellersCubit>(context).getBestSellersFav();
                        }
                      },
                      icon: isFavProduct
                          ? SvgPicture.asset('assets/images/favicon.svg', width: 27)
                          : SvgPicture.asset('assets/images/fav.svg', width: 27),
                    );
                  } else if (state is FavProductDetailsFailure) {
                    return SvgPicture.asset('assets/images/favicon.svg', width: 27);
                  } else {
                    return SvgPicture.asset('assets/images/favicon.svg', width: 27);
                  }
                },
                listener: (context, state) {
                  setState(() {
                    isFavProduct = widget.product!.favorite ?? false;
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
