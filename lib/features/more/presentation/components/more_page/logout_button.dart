import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/font_size.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: redColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
      ),
      child: Center(
        child: Text(
          'تأكيد تسجيل الخروج',
          style: TextStyle(
            color: Colors.white,
            fontSize: getResponsiveFontSize(context, fontSize: 18),
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
