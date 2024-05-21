import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/shoppingCart/presentaion/component/productsCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../models/cart_model.dart';
import '../controllers/Cart_cubit/cart_cubit.dart';
import '../controllers/update_product/update_product_cubit.dart';

class AccessoryProductCart extends StatefulWidget {
  final CartAccessory accessory;
  const AccessoryProductCart({super.key, required this.accessory});

  @override
  State<AccessoryProductCart> createState() => _AccessoryProductCartState();
}

class _AccessoryProductCartState extends State<AccessoryProductCart> {
  int? amountAccessoryChanging;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 30,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15), // Shadow color
                      spreadRadius: 10, // How much the shadow should spread
                      blurRadius: 10, // How soft the shadow should be
                      offset: const Offset(0, 5), // Changes position of shadow
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: '${AppConstants.baseUrl}${widget.accessory.accessory.image}',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                     widget.accessory.accessory.name,
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.035,
                        color: const Color(0xff25170B),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'السعر',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.042,
                      fontFamily: 'Almarai',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '${widget.accessory.accessory.price} ر.س',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                      color: const Color(0xFFCA7009),
                    ),
                  ),
                ],
              ),
              Container(
                color: const Color(0xffEAEAEA),
                height: size.height * 0.08,
                width: 2,
              ),
              ProductsCart(
                amountProduct:widget.accessory.quantity,
                maxAmount:widget.accessory.accessory.quantity,
                onAmountChange: handleAmountAccessoryChange,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: const Divider(
              height: 2,
            ),
          ),
        ],
      ),
    );
  }      void handleAmountAccessoryChange(int value) {
    setState(() {
      amountAccessoryChanging = value;
      BlocProvider.of<CartProductCubit>(context).updateAccessory(
          id:widget.accessory.id,
          quantity: amountAccessoryChanging ??widget.accessory.quantity);
      if (amountAccessoryChanging == 0) {
        BlocProvider.of<CartCubit>(context).getCart();
      }
    });
  }
}
