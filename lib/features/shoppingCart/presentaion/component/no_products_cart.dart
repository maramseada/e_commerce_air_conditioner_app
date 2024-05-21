import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/navigator.dart';
import '../../../../widgets/button.dart';
import '../../../BottomBar/BottomBar.dart';


class NoFoundProduct extends StatelessWidget {
  const NoFoundProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Column(
              children: [
                Image.asset(
                  cart,
                  width: size.width * 0.4,
                ),
                Text(
                  'لا توجد لديك منتجات بعربة ',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.05,
                    color: Color(0xff2D2525),
                  ),
                ),
                Text(
                  'التسوق',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.05,
                    color: Color(0xff2D2525),
                  ),
                ),
                SizedBox(height: size.height*0.05,),
                GestureDetector(
                  onTap:                                   (){
                    navigateWithoutHistory(context, BottomBarPage());
                  }
                  ,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
                    child: Button(text: 'تصفح المنتجات'),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height*0.05,)
          ],
        ),
      ),
    );
  }
}
