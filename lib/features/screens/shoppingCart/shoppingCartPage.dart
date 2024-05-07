import 'package:flutter/material.dart';
import '../../../api/cart_api.dart';
import '../../../constant/colors.dart';
import '../../../models/cart_model.dart';
import 'component/no_products_cart.dart';
import 'component/pay_step.dart';
import 'component/steeper.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  int _activeStepIndex = 0;  CartApi _api = CartApi();
  CartModel? data;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  return  FutureBuilder(
        future: _api.getCart(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasError) {
    return Center(
    child: Text('Error: ${snapshot.error}'),
    );
    } else if (snapshot.data == null) {
    return Container();
    } else {
    data = snapshot.data;
return RefreshIndicator(child: data!.cartAccessories.isNotEmpty || data!.cartProducts.isNotEmpty
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
        SizedBox(height: size.height*0.02,),
        Expanded(child: CartStepper()),
      ],
        ),
      ),
    ):NoFoundProduct(), onRefresh: _pullRefresh);
    }});


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
    setState(() {
    });
  }
}
