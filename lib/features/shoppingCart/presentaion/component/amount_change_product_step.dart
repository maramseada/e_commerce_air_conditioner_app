import 'package:e_commerce/features/shoppingCart/presentaion/component/product_cart_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../models/cart_model.dart';
import 'accessory_product_cart.dart';

class AmountChangeProductStep extends StatefulWidget {
  final CartModel data;
  final VoidCallback onNextStep;

  const AmountChangeProductStep({
    super.key,
    required this.data,
    required this.onNextStep,
  });

  @override
  State<AmountChangeProductStep> createState() => _AmountChangeProductStepState();
}



class _AmountChangeProductStepState extends State<AmountChangeProductStep> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 300,
              margin: EdgeInsets.only(top: size.height * 0.03, bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.06),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.data.cartProducts.length,
                      itemBuilder: (BuildContext context, int index) {


                        return ProductCartItem(product: widget.data.cartProducts[index],);
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.data.cartAccessories.length,
                      itemBuilder: (BuildContext context, int index) {


                        return AccessoryProductCart(accessory: widget.data.cartAccessories[index],);
                      },
                    ),
                  ],
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.039),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إجمالي الطلب',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.042,
                        fontFamily: 'Almarai',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      '${widget.data.total} ر.س',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Almarai',
                        color: const Color(0xFFCA7009),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _nextStep,
                  child: Container(
                    width: size.width * 0.42,
                    height: 60,
                    decoration: ShapeDecoration(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'التالي',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.05,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        Image.asset(
                          arrowL,
                          width: size.width * 0.08,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
        ],
      ),
    );
  }

  void _nextStep() {
    widget.onNextStep();
  }
}
