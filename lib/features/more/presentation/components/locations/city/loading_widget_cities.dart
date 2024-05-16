import 'package:flutter/material.dart';

import '../../../../../../core/constant/colors.dart';

class CitiesLoadingWidget extends StatelessWidget {
  const CitiesLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: DropdownButtonFormField<String>(
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFFafafaf),
        ),
        decoration: InputDecoration(
          hintText: 'المدينة',
          hintStyle: const TextStyle(
            color: grayColor,
            fontSize: 16,
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
        ), items: const [], onChanged: (String? value) {  },

      ),
    );
  }
}
