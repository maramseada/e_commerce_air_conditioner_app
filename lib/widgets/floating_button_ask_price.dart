import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';
import '../../core/constant/colors.dart';
import '../../core/constant/navigator.dart';
import '../features/screens/request_prise/request_prise.dart';

class AskPriceFloatingButton extends StatelessWidget {
  const AskPriceFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: size.width * 0.09),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            elevation: 10,
            onPressed: () {
              navigateTo(context, RequestPrice());
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            label: Text(
              'طلب عرض سعر',
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 20),
                fontWeight: FontWeight.w700,
                fontFamily: 'Almarai',
              ),
            ),
            icon: const Icon(Icons.add, color: Colors.white, size: 25),
            backgroundColor: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
