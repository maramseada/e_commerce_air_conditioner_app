import 'package:e_commerce/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../api/api.dart';
import '../../../constant/images.dart';
import '../../../models/homeModel.dart';
import '../../../models/settingsModel.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({super.key});

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  final Api _api = Api();
  HomeModel? data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child:  FutureBuilder(
        future: _api.Home(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasError) {
    return Center(
    child: Text('Error: ${snapshot.error}'),
    );
    } else if (snapshot.data == null) {
    return Container();
    } else {
      data = snapshot.data;
return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 300,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/abouttt.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  IconButton(
                    icon: Icon(
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
            Container(
              child: Column(
                children: [
                  Text(
                    'عن الشركة',
                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'نبذة بسيطة عن الشركة',
                      style: TextStyle(fontFamily: 'Almarai', color: grayColor),
                    ),
                  ),

                  Padding(padding:EdgeInsets.only(
                    bottom: 10
                  ),child: Image.asset(logoTitle, scale: size.width * 0.015)),


                  Row(
                    children: [
                      Text(
                        'تأسس عام  ',
                        style: TextStyle(
                            fontFamily: 'Farsi', fontWeight: FontWeight.w500, color: Color(0xFFAF954C), fontSize: size.width * 0.06),
                      ),
                      Text(
                        ' ١٩٧٩ ',
                        style: TextStyle(
                            fontFamily: 'Farsi', fontWeight: FontWeight.w500, color: Color(0xFFAF954C), fontSize: size.width * 0.07),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/about2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          margin: EdgeInsets.only(top:30),
          child: Text(
data!.settings![0].value,


            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 15),
          child: Text(
            data!.settings![1].value,
            style: TextStyle(
              fontFamily: 'Almarai',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Row(
            children: [
              Image.asset(
                blue,
              ),
              SizedBox(
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
                padding: EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              SizedBox(
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
                        color: Color(0xFF3F3F3F),
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
                padding: EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              SizedBox(
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
                        color: Color(0xFF3F3F3F),
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
              SizedBox(
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
                padding: EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              SizedBox(
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
                        color: Color(0xFF3F3F3F),
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
              SizedBox(
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
                padding: EdgeInsets.only(top: 5),
                child: Image.asset(
                  brown, // Asset name for the image
                ),
              ),
              SizedBox(
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
                        color: Color(0xFF3F3F3F),
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
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
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
                    SizedBox(
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
                    SizedBox(
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
                    SizedBox(
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
                    SizedBox(
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
                    SizedBox(
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
                    SizedBox(
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
              SizedBox(
                height: 50,
              )
            ],
          )),
        )
      ],
    ));
    }})
            )));
  }
}
