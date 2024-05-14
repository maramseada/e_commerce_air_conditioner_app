import 'package:e_commerce/core/constant/navigator.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constant/colors.dart';
import '../../../BottomBar/BottomBar.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
        child:
        Column(

            children: [
              SizedBox(height: size.height*0.16,),
              SvgPicture.asset('assets/images/emptyorder.svg'),
              Container(
padding: EdgeInsets.only(top: 20),
                width: size.width*0.3,
                child: Text(

                  'لا توجد لديك طلبات بالوقت الحالي',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){navigateWithoutHistory(context, BottomBarPage());},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.04, vertical: 20),
                child:  Button(text: 'تصفح المنتجات', ),
              )
              )
            ],

        ),

    );
  }
}
