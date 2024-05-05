import 'package:e_commerce/constant/navigator.dart';
import 'package:e_commerce/models/homeModel.dart';
import 'package:e_commerce/presentation/screens/home/show_accessories.dart';
import 'package:e_commerce/presentation/screens/home/show_bestsellers.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/api.dart';
import '../../../constant/font_size.dart';
import '../search/search.dart';
import 'component/bestSeller.dart';
import 'component/carousel.dart';
import 'component/sparePieces.dart';
import 'component/typesDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Api _api = Api();
  HomeModel? home;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder(
        future: _api.Home(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasError) {
    return Center(
    child: Text('Error: ${snapshot.error}'),
    );
    } else if (snapshot.data == null) {
    return Container();
    } else {
    home = snapshot.data;

    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: ListView(
        shrinkWrap: true,
        children: home != null
            ? [
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
              left: size.width * 0.05,
              right: size.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مرحبا ${home!.fName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:getResponsiveFontSize(context , fontSize: 22),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almarai',
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 0.5, color: Colors.blue),
                      ),
                      child: IconButton(
                        onPressed: () {
                          navigateTo(context, const Search());
                        },
                        icon: Image.asset(
                          'assets/images/search.png',
                          width: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.green,
                      ),
                      child: IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse(home!.whatsapp.url));
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: size.width * 0.9,
              height: 260,
              child: CarouselScreen(),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.018),
              child: GridView.builder(
                physics: const ScrollPhysics(),

                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: home!.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {

                      navigateTo(context,TypesDetails(productId:  home!.categories[index].id, productName: home!.categories[index].name,),);
                    },
                    child: Card(
                      color: Color(int.parse( home!.categories[index].color.replaceAll('#', '0xFF'))),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FutureBuilder<Widget>(
                                future: _api.getImageHome( home!.categories[index].image),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container(
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    final imageWidget = snapshot.data;
                                    return imageWidget != null
                                        ? SizedBox(
                                      child: imageWidget,
                                    )
                                        : const SizedBox(); //
                                  }
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              home!.categories[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.04
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ); // You can replace the AssetImage with NetworkImage for images from the internet
                  // return Image.asset(
                  //   'assets/images/types$index.png', // Replace with your image asset path
                  //   fit: BoxFit.cover, // Adjust the BoxFit property as needed
                  // );
                },
              )

          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: size.height * 0.018),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الأكثر مبيعا',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize:getResponsiveFontSize(context, fontSize: 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    Text(
                      'أكثر منتجاتنا تحقيقا للمبيعات',
                      style: TextStyle(color: Colors.grey, fontFamily: 'Almarai', fontSize: getResponsiveFontSize(context, fontSize: 14),),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {                                      navigateTo(context,ShowBestSellers( productName:'الأكثر مبيعا',),);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'عرض المزيد',
                        style: TextStyle(
                          color: const Color(0xFFCA7009),
                          fontSize: getResponsiveFontSize(context, fontSize: 16),
                          fontFamily: 'Almarai',
                        ),
                      ),
                      SizedBox(width: size.width * 0.025),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: const Color(0xFFCA7009),
                        size: size.width * 0.044,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            height: 400,
            child: BestSeller(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: size.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'فتحات التكييف الألومنيوم',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: getResponsiveFontSize(context, fontSize: 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    Text(
                      'مبيعات فتحات التكييف الألومنيوم المتاحة لدينا',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Almarai',
                        fontSize:  getResponsiveFontSize(context, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    navigateTo(context,ShowMoreAccessories( productName:'فتحات التكييف الألومنيوم',),);


                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'عرض المزيد',
                        style: TextStyle(
                          color: const Color(0xFFCA7009),
                          fontSize: getResponsiveFontSize(context, fontSize: 16),
                          fontFamily: 'Almarai',
                        ),
                      ),
                      SizedBox(width: size.width * 0.025),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: const Color(0xFFCA7009),
                        size: size.width * 0.044,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: size.width * 0.018),
            height: 350,
            child: SparePieceScreen(),
          ),
        ]
            : [
          // Placeholder widget when home data is null
          const Center(
            child: Text(
              'لا تتوفر بيانات تأكد من اتصال الانترنت ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',

              ),
            ),
          ),
        ],
      ),
    );
    }}) ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
    });
  }
  Future<void> _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
