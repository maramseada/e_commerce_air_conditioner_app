import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';
import '../../screens/locations/edit_address.dart';

class NearByLocationWidget extends StatelessWidget {
  final String landmarkInitial;
  const NearByLocationWidget({super.key, required this.landmarkInitial});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        onChanged: (value) {
          landmark = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'برجاء ادخال أقرب علامة مميزة للعنوان ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: landmarkInitial,
          hintStyle: TextStyle(
            color: grayColor,
            fontSize:getResponsiveFontSize(context, fontSize: 18),
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: const Color(0xFFF7F7F7),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFF7F7F7),
            ),
            borderRadius: BorderRadius.circular(38),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(38),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(38),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFF7F7F7),
            ),
            borderRadius: BorderRadius.circular(38),
          ),
        ),
      ),
    );
  }
}
