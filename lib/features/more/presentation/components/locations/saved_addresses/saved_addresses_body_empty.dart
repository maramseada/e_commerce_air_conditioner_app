import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constant/colors.dart';
import '../../../../../../core/constant/navigator.dart';
import '../../../../../../widgets/button.dart';

import '../../../screens/locations/add_address.dart';

class SavedAddressesBodyEmpty extends StatelessWidget {
  const SavedAddressesBodyEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.16,
          ),
          SvgPicture.asset('assets/images/Group 176180.svg'),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: size.width * 0.34,
            child: Text(
              'لا توجد لديك عناوين محفوظة',
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
                navigateTo(context, const AddAddressScreen());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 20),
                child: const Button(
                  text: 'إضافة عنوان جديد',
                ),
              ))
        ],
      ),
    );
  }
}
