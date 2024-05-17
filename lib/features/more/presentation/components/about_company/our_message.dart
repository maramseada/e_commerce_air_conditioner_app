import 'package:flutter/cupertino.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/images.dart';
class OurMessage extends StatelessWidget {
  const OurMessage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [   Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Row(
          children: [
            Image.asset(
              blue,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'رسالتنا',
              style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
            )
          ],
        ),
      ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                // Wrap the Column with Expanded
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      'للوصـول ألعلـي معاييـر الجـودة باألعتمـاد علـي األسـاليب العلميـة و البحـث عـن احـدث صيحـات  التكنولوجيـا الحديثـة لألرتقـاء و تطويـر المنتـج و تقليـل نسـب األخطـاء',
                      style: TextStyle(
                        color: const Color(0xFF3F3F3F),
                        fontFamily: 'Almarai',
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                // Wrap the Column with Expanded
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      'راحة العميل والعمل علي توفير جميع احتياجات عمالئنا باقل اعباء مالية عليهم',
                      style: TextStyle(
                        color: const Color(0xFF3F3F3F),
                        fontFamily: 'Almarai',
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Row(
            children: [
              Image.asset(
                blue,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'أهدافنا وإهتمامتنا',
                style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                // Wrap the Column with Expanded
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      'أن يصبــح البكــر للتكييــف األول فــي مجــال تكييــف الهــواء وذلــك عــن طريــق التأكــد مــن جــودة المنتــج ودقــة التنفيــذ مــع كامــل اإلهتمــام بخدمــات مــا بعــد البيــع',
                      style: TextStyle(
                        color: const Color(0xFF3F3F3F),
                        fontFamily: 'Almarai',
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Row(
            children: [
              Image.asset(
                blue,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'الآمان',
                style: TextStyle(color: kPrimaryColor, fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.05, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                // Wrap the Column with Expanded
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      'مته مــن اهــم اولوياتنــا و لذلــك نحــرص علــي األعتمــاد علــي اجــود انــواع  حمايــة العميــل وســاء كالعـوازل الداخليـة لمجـاري الهـواء الخاليـة مـن ماده الخامـات وأكثرهـا حفاظـاً علـي صحـة العمـال و الســيلكون المضــاد للبيكتريــا و مكائــن المكيفــات الأمنــة و انواعهــا المخصصــة للألطفـال',
                      style: TextStyle(
                        color: const Color(0xFF3F3F3F),
                        fontFamily: 'Almarai',
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )],
    );
  }
}
