import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../widgets/button.dart';
import '../controller/cart_product_cubit.dart';
import '../controller/product/product_details_state.dart';

class AddToCartProduct extends StatelessWidget {
  const AddToCartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return     BlocBuilder<CartProductDetailsCubit, CartProductDetailsState>(
      builder: (context, state) {
        if (state is CartProductDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartProductDetailsFailure) {
          const  snackBar =  SnackBar(
            content:  Text(
              'لم يتم إضافة المنتج إلى عربة التسوق',
              style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white, // Set your desired background color here
          );
          // Show the SnackBar
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
          return const Button(
            text: 'إضافة إلى عربة التسوق',
          );
        } else if (state is CartProductDetailsSuccess) {
          // Show the button when the operation is successful
          // Show SnackBar after the product is added to the cart
          const  snackBar =  SnackBar(
            content:  Text(
              'تمت إضافة المنتج إلى عربة التسوق بنجاح',
              style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white, // Set your desired background color here
          );
          // Show the SnackBar
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
          // Show the button
          return const Button(
            text: 'إضافة إلى عربة التسوق',
          );
        } else {
          // Show the button if it's not in loading or failure state
          return const Button(
            text: 'إضافة إلى عربة التسوق',
          );
        }
      },
    );
  }
}
