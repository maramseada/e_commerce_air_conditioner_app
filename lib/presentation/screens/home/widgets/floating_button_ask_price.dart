import 'package:flutter/material.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/navigator.dart';
import '../../request_prise/request_prise.dart';

class AskPriceFloatingButton extends StatelessWidget {
  const AskPriceFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(right: size.width / 10),
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
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.w700,
              fontFamily: 'Almarai',
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.white, size: 25),
          backgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}
