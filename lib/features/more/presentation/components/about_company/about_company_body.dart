import 'package:flutter/cupertino.dart';

import '../../../../../models/settingsModel.dart';

class AboutCompanyBody extends StatelessWidget {
  final List<SettingsModel> data;

  const AboutCompanyBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [       Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          data[0].value,
          style: const TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            data[1].value,
            style: const TextStyle(
              fontFamily: 'Almarai',
            ),
            textAlign: TextAlign.center,
          ),
        ),],
    );
  }
}
