import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/shoppingCart/presentaion/component/productsCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../models/cart_model.dart';
import '../../../detailsProduct/presentation/widgets/Radio.dart';
import '../controllers/Cart_cubit/cart_cubit.dart';
import '../controllers/update_product/update_product_cubit.dart';

class ProductCartItem extends StatefulWidget {
  final CartProduct product;
  const ProductCartItem({super.key, required this.product});

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}
bool incrementAmount = false;
bool isUpdatingProduct = false;
bool isUpdatingAccessory = false;
List<String> errors = [];
int? addsId;
int? amountChanging;
String? amountString;

class _ProductCartItemState extends State<ProductCartItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
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
                imageUrl: '${AppConstants.baseUrl}${widget.product.product.mainImage}',
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.product.name,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.035,
                    color: const Color(0xff25170B),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  child: CachedNetworkImage(
                    imageUrl: '${AppConstants.baseUrl}${widget.product.product.brand.image}',
                    width: 60,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        RadioScreen(
          selectedIndex: widget.product.add.id,
          onItemSelected: handleItemSelected,
        ),
        const SizedBox(
          height: 20,
        ),
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
                  '${widget.product.product.price} ر.س',
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
              amountProduct: widget.product.quantity,
              maxAmount: widget.product.product.quantity,
              onAmountChange: handleAmountChange,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
          child: const Divider(
            height: 2,
          ),
        ),
      ],
    );
  }     void handleItemSelected(int value) {
    setState(() {
      addsId = value;
      BlocProvider.of<CartProductCubit>(context).updateProduct(
          id: widget.product.id,
          quantity: amountChanging ?? widget.product.quantity,
          addId: addsId ?? widget.product.add.id);
    });
  }

  void handleAmountChange(int value) {
    setState(() {
      amountChanging = value;
      BlocProvider.of<CartProductCubit>(context).updateProduct(
          id: widget.product.id,
          quantity: amountChanging ?? widget.product.quantity,
          addId: addsId ?? widget.product.add.id);
      if (amountChanging == 0) {
        BlocProvider.of<CartCubit>(context).getCart();
      }
    });
  }
}
