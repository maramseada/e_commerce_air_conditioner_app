import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../models/ordermodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../detailsProduct/presentation/controller/cart_product_cubit.dart';

class FilteredProduct extends StatefulWidget {
  final ProductsModel? product;
  const FilteredProduct({super.key, required this.product});

  @override
  State<FilteredProduct> createState() => _FilteredProductState();
}

class _FilteredProductState extends State<FilteredProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
      decoration: BoxDecoration(
        color: widget.product?.quantity != 0 ? Colors.white : paleGrayColor,
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
            child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: 'https://albakr-ac.com/${widget.product?.image}',
                errorWidget: (context, url, error) => const Icon(Icons.access_alarm)),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.only(top: size.height * 0.01),
            alignment: Alignment.centerRight,
            child: Text(
              widget.product?.name?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: size.width * 0.04,
                fontFamily: 'Almarai',
              ),
            ),
          ),
          widget.product?.brand != null
              ? Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 30,
              child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: 'https://albakr-ac.com/${widget.product?.brand?.image?? ''}',
                  errorWidget: (context, url, error) => const Icon(Icons.access_alarm)),
            ),
          )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 18,
                initialRating: widget.product?.totalRate.toDouble()?? 5.0,
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
              const SizedBox(width: 5),
              Text(
                '(${widget.product?.totalRate?? 5.0})',
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
              '${widget.product?.price} ر.س ',
              style: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',
                color: const Color(0xFFCA7009),
                textBaseline: TextBaseline.ideographic,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: widget.product?.quantity != 0
                ? GestureDetector(
              onTap: () {
                BlocProvider.of<CartProductDetailsCubit>(context).addToCart(
                  id: widget.product?.id.toString() ?? '',
                  amount: 1,
                  context: context,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.07),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1),
                    ),
                  ],
                  border: Border.all(width: 1.0, color: const Color(0x3D1D75B1)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(cartIcon),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      'أضف للعربة',
                      style: TextStyle(
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                          fontSize: getResponsiveFontSize(context, fontSize: 16),
                          color: kPrimaryColor),
                    ),
                  ],
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
          ),
        ],
      ),
    );
  }
}
