import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07), // Shadow color
            spreadRadius: 1, // How much the shadow should spread
            blurRadius: 1, // How soft the shadow should be
            offset: const Offset(1, 1), // Changes position of shadow
          ),
        ],
        border: Border.all(width: 1.0, color: borderButtonColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/shopping-cart.svg',
          ),
          const SizedBox(
            width: 7,
          ),
          const Text(
            'أضف للعربة',
            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w700, fontSize: 14, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
