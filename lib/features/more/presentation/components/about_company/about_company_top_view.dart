import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/images.dart';

class AboutCompanyTopView extends StatelessWidget {
  const AboutCompanyTopView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 300,
          width: size.width * 0.3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/abouttt.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        Column(
          children: [
            Text(
              'عن الشركة',
              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'نبذة بسيطة عن الشركة',
                style: TextStyle(fontFamily: 'Almarai', color: grayColor),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 10), child: Image.asset(logoTitle, scale: size.width * 0.015)),
            Row(
              children: [
                Text(
                  'تأسس عام  ',
                  style: TextStyle(fontFamily: 'Farsi', fontWeight: FontWeight.w500, color: const Color(0xFFAF954C), fontSize: size.width * 0.06),
                ),
                Text(
                  ' ١٩٧٩ ',
                  style: TextStyle(fontFamily: 'Farsi', fontWeight: FontWeight.w500, color: const Color(0xFFAF954C), fontSize: size.width * 0.07),
                ),
              ],
            ),
          ],
        ),
        Container(
          height: 300,
          width: size.width * 0.3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/about2.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
