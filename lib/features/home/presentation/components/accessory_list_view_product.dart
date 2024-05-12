import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../api/api.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/font_size.dart';
import '../../../../models/accessor_model.dart';
import '../../../../widgets/add_to_cart_button.dart';
import '../../../detailsProduct/presentation/controller/cart_product_cubit.dart';
import '../controllers/Accessories/accessory_cubit.dart';
import '../controllers/fav_accessory/fav_accessory_cubit.dart';
import '../controllers/fav_accessory/fav_accessory_state.dart';

class AccessoryListViewProduct extends StatefulWidget {
  final AccessoryModel? product;

  const AccessoryListViewProduct({super.key, required this.product});

  @override
  State<AccessoryListViewProduct> createState() => _AccessoryListViewProductState();
}

class _AccessoryListViewProductState extends State<AccessoryListViewProduct> {
  Api api = Api();
  late bool isFavProduct;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<FavAccessoryCubit>(context);

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
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
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: 'https://albakr-ac.com/${widget.product!.image}',
                    errorWidget: (context, url, error) => const Icon(Icons.access_alarm)),
              ),
              Container(
                  height: 60,
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.product!.name,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: getResponsiveFontSize(context, fontSize: 16), fontFamily: 'Almarai'),
                  )),
              Container(
                alignment: Alignment.centerRight,
                child: (Text(
                  '${widget.product!.price} ر.س ',
                  style: TextStyle(
                      fontSize: getResponsiveFontSize(context, fontSize: 16),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                      color: const Color(0xFFCA7009)),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.product!.quantity != 0
                        ? GestureDetector(
                            onTap: () {
                              BlocProvider.of<CartProductDetailsCubit>(context).addToCartAccessory(
                                id: widget.product!.id.toString(),
                                amount: 1,
                                context: context,
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
                    BlocConsumer<FavAccessoryCubit, FavAccessoryState>(
                      builder: (context, state) {
                        if (state is FavAccessoryLoading) {
                          return SvgPicture.asset('assets/images/fav.svg', width: 27);
                        } else if (state is FavAccessorySuccess) {
                          isFavProduct = widget.product!.favorite ?? false;
                          return IconButton(
                              onPressed: () {
                                if (isFavProduct) {
                                  cubit.unFavAccessory(id: widget.product!.id, context: context);
                                  BlocProvider.of<AccessoryCubit>(context).getAccessoryFav();
                                } else {
                                  cubit.favAccessory(id: widget.product!.id, context: context);
                                  BlocProvider.of<AccessoryCubit>(context).getAccessoryFav();
                                }
                              },
                              icon: isFavProduct
                                  ? SvgPicture.asset('assets/images/favicon.svg', width: 27)
                                  : SvgPicture.asset('assets/images/fav.svg', width: 27));
                        } else if (state is FavAccessoryFailure) {
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
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
