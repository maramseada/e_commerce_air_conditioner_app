
import 'package:flutter/material.dart';

import '../../../../../core/constant/images.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {    Size size = MediaQuery.of(context).size;

  return Column(
      children: [
        Image.asset(
          noFoundSearch,
          width: size.width * 0.25,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          'عذا ,  لا توجد نتائج للبحث',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.05,
            color: const Color(0xff2D2525),
          ),
        ),
      ],
    );
  }
}
