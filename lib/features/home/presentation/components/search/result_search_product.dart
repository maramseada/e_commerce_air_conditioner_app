import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../models/ordermodel.dart';
import '../../../../../widgets/add_to_cart_button.dart';
import '../../../../detailsProduct/presentation/controller/cart_product_cubit.dart';

class ResultSearchProduct extends StatelessWidget {
  final ProductsModel product;

  const ResultSearchProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
              child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: 'https://albakr-ac.com/${product.image}',
                  errorWidget: (context, url, error) => const Icon(Icons.access_alarm))),
          Container(
            height: 60,
            padding: EdgeInsets.only(top: size.height * 0.01),
            alignment: Alignment.centerRight,
            child: Text(
              product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.04,
                fontFamily: 'Almarai',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 20,
                initialRating: product.totalRate.toDouble(),
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
                '(${product.totalRate})',
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
              '${product.price} ر.س ',
              style: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',
                color: const Color(0xFFCA7009),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          product.quantity != 0
              ? GestureDetector(
                  onTap: () {
                    BlocProvider.of<CartProductDetailsCubit>(context).addToCart(
                      id: product.id.toString(),
                      amount: 1,
                      context: context,
                    );
                  },
                  child: const AddToCartButton())
              : Text(
                  'المنتج غير متوفر',
                  style: TextStyle(
                    color: redColor,
                    fontSize: size.width * 0.043,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almarai',
                  ),
                ),
        ],
      ),
    );
  }
}
