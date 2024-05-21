import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/cart_model.dart';
import '../controllers/Cart_cubit/cart_cubit.dart';
import '../controllers/Cart_cubit/cart_state.dart';
import 'amount_change_product_step.dart';


class ProductStep extends StatefulWidget {
  const ProductStep({
    Key? key,
    required this.onNextStep,
    this.formKey,
    this.isActive = false,
  }) : super(key: key);

  final VoidCallback onNextStep;
  final bool isActive;
  final formKey;

  @override
  State<ProductStep> createState() => _ProductStepState();
}

class _ProductStepState extends State<ProductStep> {

  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).getCart();
    super.initState();
  }


    @override
    Widget build(BuildContext context) {
      late CartModel cart;

      return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<CartCubit, CartState>(
          builder: (BuildContext context, state) {
            if (state is CartSuccess) {
              cart = state.cart;
              return AmountChangeProductStep(
                data: cart,
                onNextStep: widget.onNextStep,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
          listener: (BuildContext context, Object? state) {},

            ),
      );
  }

}

