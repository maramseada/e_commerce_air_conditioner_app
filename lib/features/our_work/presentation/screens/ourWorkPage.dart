import 'package:flutter/material.dart';
import '../../../../../constant/colors.dart';
import '../components/our_work/our_work_body.dart';

class OurWorkPage extends StatefulWidget {
  const OurWorkPage({super.key});

  @override
  State<OurWorkPage> createState() => _OurWorkPageState();
}

class _OurWorkPageState extends State<OurWorkPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Column(
          children: [
            Text(
              'أعمالنا',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w800,
                fontSize: size.width * 0.05,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 8,
            ),Text(
              'تعرف على أعمالنا التي نقدمها',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.04,
                color: grayColor,
              ),
            ),
          ],
        ),
      ),
      body:const OurWorkBody()
    );
  }


}
