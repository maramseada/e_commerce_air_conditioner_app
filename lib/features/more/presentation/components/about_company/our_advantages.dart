import 'package:flutter/cupertino.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/images.dart';

class OurAdvantages extends StatelessWidget {
  const OurAdvantages({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return     Container(
      margin: const EdgeInsets.only(top: 50),
      decoration: const BoxDecoration(
        color: Color(0Xfff6f9fc),
      ),
      child: (Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 15, right: size.width * 0.06),
            child: Text(
              'مميزاتنا',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: size.width * 0.055,
                fontFamily: 'Almarai',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Image.asset('assets/images/grayline.png'),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 0.01, right: size.width * 0.05, top: 15),
            child: Row(
              children: [
                Image.asset(blueLine),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'الدقة في المواعيد في جميع مراحل العمل',
                    style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontSize: size.width * 0.04),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.05, top: 15),
            child: Row(
              children: [
                Image.asset(blueLine),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    ' يتم تصنيع جميع مراحل التكييف من مجاري  الهواء او اوجه المكيفات في مصانعنا',
                    style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontSize: size.width * 0.04),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.05, top: 15),
            child: Row(
              children: [
                Image.asset(blueLine),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'الإشراف المستمر في مراحل التنفيذ',
                    style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontSize: size.width * 0.04),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.05, top: 15),
            child: Row(
              children: [
                Image.asset(blueLine),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    ' نخبة من الكوادر البشرية الفنيين والمشرفين ذوي الخبرة العالية في مجال تكييف الهواء',
                    style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontSize: size.width * 0.04),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.05, top: 15),
            child: Row(
              children: [
                Image.asset(blueLine),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'الإهتمام الجاد لخدمة ما بعد البيع لإلطمئنان علي مستوي العمل ولخدمة عمالئنا',
                    style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontSize: size.width * 0.04),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.05, top: 15),
            child: Row(
              children: [
                Image.asset(blueLine),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'للعميل اولوية قصوي لدينا وهذا ما يميزنا عن غيرنا من شركات التكييف',
                    style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontSize: size.width * 0.04),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}
