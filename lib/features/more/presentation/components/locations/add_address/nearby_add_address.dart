import 'package:e_commerce/features/more/presentation/screens/locations/add_address.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colors.dart';
import '../../../../../../core/constant/font_size.dart';

class NearByAddAddress extends StatefulWidget {
  const NearByAddAddress({super.key});

  @override
  State<NearByAddAddress> createState() => _NearByAddAddressState();
}

class _NearByAddAddressState extends State<NearByAddAddress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        onChanged: (value) {
          landmarkAddAddress = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'برجاء ادخال أقرب علامة مميزة للعنوان ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: 'أقرب علامة مميزة للعنوان',
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
