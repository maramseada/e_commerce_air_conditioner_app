import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant/colors.dart';
import '../../../../../models/homeModel.dart';
import '../../../../../widgets/add_to_cart_button.dart';
import '../../../../detailsProduct/presentation/components/accessory_details.dart';
import '../../../../detailsProduct/presentation/controller/cart_product_cubit.dart';
import '../../../../home/presentation/controllers/accessory/acessory_details_cubit.dart';
import '../../../../home/presentation/controllers/fav_accessory/fav_accessory_cubit.dart';
import '../../../../home/presentation/controllers/fav_accessory/fav_accessory_state.dart';
import '../../controllers/Favourites_cubit/favourites_cubit.dart';

class FavouriteAccessory extends StatelessWidget {
  final Accessory accessory ;
  const FavouriteAccessory({super.key, required this.accessory});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late  bool isFavProduct ;

    final cubit = BlocProvider.of<FavAccessoryCubit>(context);
    return GestureDetector(
        onTap: () {
          BlocProvider.of<AccessoryDetailsCubit>(context).getAccessoryDetails(
            id: accessory.id,
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccessoryDetails(
                    id: accessory.id,
                  ))).then((_) =>                                   BlocProvider.of<FavouritesCubit>(context).favouriteProducts());
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: size.height * 0.02),
              decoration: BoxDecoration(
                color: accessory.quantity != 0 ? Colors.white : paleGrayColor,
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
                      height: size.height * 0.11,
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
                        imageUrl: 'https://albakr-ac.com/${accessory.image}',
                      )),
                  Container(
                    height: size.height * 0.06,
                    padding: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerRight,
                    child: Text(
                      accessory.name,
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
                      '${accessory.price} ر.س ',
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Almarai',
                        color: secondColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accessory.quantity != 0
                            ? Expanded(
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<CartProductDetailsCubit>(context).addToCartAccessory(
                                id: accessory.id.toString(),
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
                            fontSize: size.width * 0.043,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                          ),
                        ),
                        BlocConsumer<FavAccessoryCubit, FavAccessoryState>(
                          builder: (context, state) {
                           if (state is FavAccessorySuccess) {
                              isFavProduct = accessory.favorite ?? false;
                              return IconButton(
                                  onPressed: () {
                                    if (isFavProduct) {
                                      cubit.unFavAccessory(id: accessory.id, context: context);
                                      BlocProvider.of<FavouritesCubit>(context).favouriteProducts();

                                    } else {
                                      cubit.favAccessory(id: accessory.id, context: context);
                                      BlocProvider.of<FavouritesCubit>(context).favouriteProducts();

                                    }
                                  },
                                  icon: isFavProduct
                                      ? SvgPicture.asset('assets/images/favicon.svg', width: 27)
                                      :SvgPicture.asset('assets/images/fav.svg', width: 27)
                              );
                            }  else {
                              return SvgPicture.asset('assets/images/favicon.svg', width: 27);
                            }
                          },
                          listener: (context, state) {
                              isFavProduct = accessory.favorite ?? false;

                          },
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
