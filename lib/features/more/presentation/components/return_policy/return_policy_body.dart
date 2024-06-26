import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../models/settingsModel.dart';

class ReturnPolicyBody extends StatelessWidget {
  final List<SettingsModel> data;

  const ReturnPolicyBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/return.svg',
                width: size.width * 0.4,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  data[0].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Almarai', fontSize: size.width * 0.06),
                )),
            Container(
              padding: EdgeInsets.only(
                top: 20,
                right: size.width * 0.05,
                left: size.width * 0.05,
              ),
              child: Text(
                data[0].value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: size.width * 0.04, fontFamily: 'Almarai', fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 10,
                right: size.width * 0.05,
                left: size.width * 0.05,
              ),
              child: Text(
                data[1].value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.035,
                  fontFamily: 'Almarai',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
