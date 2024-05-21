import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';
import '../../screens/locations/edit_address.dart';

class BuildingTextField extends StatelessWidget {
  final String buildingNumber;
  const BuildingTextField({super.key, required this.buildingNumber});

  @override
  Widget build(BuildContext context) {
    return     Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        onChanged: (value) {
          buildingText = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'برجاء ادخال رقم المبنى ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: buildingNumber??'رقم المبنى',
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
