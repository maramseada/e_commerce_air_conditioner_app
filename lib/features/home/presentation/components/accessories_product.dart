import 'package:e_commerce/constant/font_size.dart';
import 'package:e_commerce/features/home/presentation/controllers/Accessories/accessory_cubit.dart';
import 'package:e_commerce/features/home/presentation/controllers/fav_accessory/fav_accessory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../api/api.dart';
import '../../../../constant/colors.dart';
import '../../../../models/accessor_model.dart';
import '../../../../widgets/add_to_cart_button.dart';
import '../../../detailsProduct/presentation/controller/cart_product_cubit.dart';
import '../controllers/fav_accessory/fav_accessory_cubit.dart';

class AccessoriesProduct extends StatefulWidget {
  final AccessoryModel product;

  const AccessoriesProduct({super.key, required this.product});

  @override
  State<AccessoriesProduct> createState() => _AccessoriesProductState();
}

class _AccessoriesProductState extends State<AccessoriesProduct> {
  Api api = Api();
  bool isFavProduct = false;
  late Future<Widget> _imageFuture;

  @override
  void initState() {
    isFavProduct = widget.product.favorite ?? false;
    _imageFuture = api.ImageHome(widget.product.image);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<FavAccessoryCubit>(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical:8),

          decoration: BoxDecoration(
            color: widget.product.quantity != 0
                ?  Colors.white:
            paleGrayColor,
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
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05), // Shadow color
                    spreadRadius: 1, // How much the shadow should spread
                    blurRadius: 10, // How soft the shadow should be
                    offset: const Offset(0, 5), // Changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://albakr-ac.com/${widget.product.image}',
                    )
                )),
          ),

              Container(
                height: size.height*0.06,
                padding: EdgeInsets.only(top: size.height * 0.01),
                alignment: Alignment.centerRight,
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.035,
                    fontFamily: 'Almarai',
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${widget.product.price} ر.س ',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.product.quantity != 0
                        ? GestureDetector(
                      onTap:(){
                        BlocProvider.of<CartProductDetailsCubit>(context).addToCartAccessory(
                          id: widget.product.id.toString(),
                          amount: 1, context: context,
                        );                      },
                      child:const AddToCartButton(),
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
                    BlocConsumer<FavAccessoryCubit, FavAccessoryState>(
                      builder: (context, state) {
                        if (state is FavAccessoryLoading) {
                          // Show a loading indicator
                          return const SizedBox();
                        } else if (state is FavAccessorySuccess) {
                          // Access the success state and build your UI accordingly
                          return IconButton(
                            onPressed: () {
                              if (isFavProduct) {
                                cubit.unFavAccessory(id: widget.product.id);
                                BlocProvider.of<AccessoryCubit>(context).getAccessoryFav();

                              } else {
                                cubit.favAccessory(id: widget.product.id);
                                BlocProvider.of<AccessoryCubit>(context).getAccessoryFav();

                              }
                            },
                            icon: isFavProduct
                                ? SvgPicture.asset('assets/images/favicon.svg', width: 23)
                                :SvgPicture.asset('assets/images/fav.svg', width: 23)
                          );
                        } else if (state is FavAccessoryFailure) {
                          // Handle the failure state
                          return SvgPicture.asset('assets/images/favicon.svg', width: 23);
                        } else {
                          //todo see the sizzee
                          return SvgPicture.asset('assets/images/favicon.svg', width: 23);
                        }
                      },
                      listener: (context, state) {
                     setState(() {
                       isFavProduct = widget.product.favorite ?? false;
                     });

                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
