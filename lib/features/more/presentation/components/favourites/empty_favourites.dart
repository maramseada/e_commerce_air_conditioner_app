import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/navigator.dart';
import '../../../../../widgets/button.dart';
import '../../../../BottomBar/BottomBar.dart';

class EmptyFavourites extends StatelessWidget {
  const EmptyFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,

          body: SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.16,
                    ),
                    SvgPicture.asset('assets/images/favpageicon.svg'),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: size.width * 0.3,
                      child: Text(
                        'لا توجد لديك منتجات بالمفضلة',
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
                        onTap: () {
                          navigateWithoutHistory(context, BottomBarPage());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 20),
                          child: const Button(
                            text: 'تصفح المنتجات',
                          ),
                        ))
                  ],
                ),
              )),
        ));
  }
}
