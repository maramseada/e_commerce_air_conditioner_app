import 'package:flutter/material.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/images.dart';
import '../../../../widgets/button.dart';

class SuccessOrder extends StatelessWidget {
  SuccessOrder({super.key});

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
      height: size.height * 0.45,
      width: double.infinity,
      child: Column(children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        Image.asset(
          circleCheck,
          height: size.height * 0.08,
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Text(
          'تم إرسال طلبك',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w800,
            fontSize: size.width * 0.05,
            color: Colors.black,
          ),
        ),
        Text(
          ' بنجاح',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w800,
            fontSize: size.width * 0.05,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          'قم بالذهاب إلى تفاصيل الطلب للإطلاع على ',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.04,
            color: grayColor,
          ),
        ),
        Text(
          'كافة التفاصيل الخاصة بطلبك',
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
        GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Button(
            text: 'تفاصيل الطلب',
            inProgress: progress,
          ),
        ),
      ]),
    );
  }
}
