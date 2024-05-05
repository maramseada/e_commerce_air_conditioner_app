import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constant/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../api/api.dart';
import '../../../../models/homeModel.dart';

class CarouselScreen extends StatefulWidget {
  CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  late CarouselController controller;
  int currentIndex = 0;
  final Api _api = Api();
  List<BannerModel>? banners;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: _api.banners(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            return Container();
          } else {
            banners = snapshot.data;

            List<Widget> lstWidget = [];
            for (int i = 0; i < banners!.length; i++) {
              lstWidget.add(
                Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: FutureBuilder<Widget>(
                          future: _api.getImageHome(banners![2].image),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container();
                            } else if (snapshot.hasError) {
                              return Container();
                            } else {
                              final imageWidget = snapshot.data;
                              return imageWidget != null
                                  ? SizedBox(
                                child: imageWidget,
                              )
                                  : const SizedBox(); //
                            }
                          }), // Use ClipRRect to clip the image
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      height: size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'كل ما تحتاجه من المكيفات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getResponsiveFontSize(context, fontSize: 18),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Almarai',
                            ),
                          ),
                          Container(
                            width: size.width * 0.5,
                            child: Text(
                              'أصبح سهلا الآن وبين يديك فقط أطب ما تحتاجه ونصله إليك',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: getResponsiveFontSize(context, fontSize: 14),
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Almarai',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return    Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                height: 270,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: size.width * 0.018),
                      height: size.height * 0.35,
                      child: CarouselSlider(
                        carouselController: controller,
                        items: lstWidget,
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50.0,
                      left: 50,
                      right: 50,
                      child: DotsIndicator(
                        dotsCount: banners!.length,
                        position: currentIndex,
                        onTap: (index) {
                          controller.animateToPage(index);
                        },
                        decorator: DotsDecorator(
                          color: Colors.grey,
                          activeColor: Colors.white,
                          size: const Size.square(12.0),
                          activeSize: const Size(24.0, 12.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

