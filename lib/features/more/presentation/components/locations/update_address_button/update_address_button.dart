import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colors.dart';

class UpdateAddressButton extends StatelessWidget {
  const UpdateAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
        child: Center(
          child: Text(
            'حفظ العنوان',
            style: TextStyle(
              color: Colors.white,
              fontSize:getResponsiveFontSize(context, fontSize: 20),
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
  }
}
