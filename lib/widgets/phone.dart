import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../constant/colors.dart';


class Phone extends StatefulWidget {

  Phone({this.onChanged});

  final void Function(PhoneNumber)? onChanged;

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  bool isPhoneNumberValid = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: IntlPhoneField(
          showDropdownIcon: false,
          textAlign: TextAlign.right,
          // dropdownIconPosition: IconPosition.trailing,
          initialCountryCode: 'SA',
          languageCode: 'ar',
          flagsButtonMargin: EdgeInsets.symmetric(horizontal: 15),
          // disableLengthCheck: true,
          decoration: InputDecoration(
            hintText: 'رقم الجوال',
            hintStyle:TextStyle(
              color: grayColor,
              fontSize: size.width * 0.04,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w600,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: const Color(0xFFF1F1F1),
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
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
