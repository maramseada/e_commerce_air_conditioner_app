import 'package:e_commerce/features/shoppingCart/presentaion/controllers/Cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/cart_model.dart';

import '../component/no_products_cart.dart';
import '../component/steeper.dart';
import '../controllers/Cart_cubit/cart_state.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  int _activeStepIndex = 0;
  // @override
  // void initState() {
  //   BlocProvider.of<CartCubit>(context).getCart();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<CartCubit, CartState>(builder: (BuildContext context, state) {
      CartModel data = BlocProvider
          .of<CartCubit>(context)
          .cart;
      return RefreshIndicator(
          onRefresh: _pullRefresh,
          child: data.cartAccessories.isNotEmpty || data.cartProducts.isNotEmpty
              ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                // backgroundColor:Color(0xffefeeee),
                title: Text(
                  'عربة التسوق',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w800,
                    fontSize: size.width * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Text(
                    'تفاصيل عربة التسوق الخاصة بك',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.04,
                      color: grayColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Expanded(child: CartStepper()),
                ],
              ),
            ),
          )
              : const NoFoundProduct());
    });
  }

  void _nextStep() {
    if (_activeStepIndex < 1) {
      setState(() {
        _activeStepIndex++;
      });
    }
  }

  void _backStep() {
    if (_activeStepIndex > 0) {
      setState(() {
        _activeStepIndex--;
      });
    }
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
