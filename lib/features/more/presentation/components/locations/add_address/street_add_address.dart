import 'package:e_commerce/features/more/presentation/screens/locations/add_address.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colors.dart';
import '../../../../../../core/constant/font_size.dart';

class StreetAddAddress extends StatefulWidget {
  const StreetAddAddress({super.key});

  @override
  State<StreetAddAddress> createState() => _StreetAddAddressState();
}

class _StreetAddAddressState extends State<StreetAddAddress> {
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
    streetAddAddress = value;
    },
    validator: (value) {
    if (value!.isEmpty) {
    return 'برجاء ادخال رقم الشارع ';
    } else {
    return null;
    }
    },
    decoration: InputDecoration(
    hintText:  'رقم الشارع',
    hintStyle: TextStyle(
    color: grayColor,
    fontSize: getResponsiveFontSize(context, fontSize: 18),
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
