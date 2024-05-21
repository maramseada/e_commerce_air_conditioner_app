import 'package:flutter/material.dart';

import '../../../../../../core/constant/colors.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.079,
      margin: EdgeInsets.only(
        top: 30,
        left: size.width * 0.035,
        right: size.width * 0.035,
      ),
      decoration: ShapeDecoration(
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff3886ba)),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: size.width * 0.04,
          ),
          Text(
            'إضافة العنوان',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.05,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
