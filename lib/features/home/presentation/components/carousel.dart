import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/homeModel.dart';
import '../controllers/Carousel/carousel_cubit.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  late CarouselController controller;
  int currentIndex = 0;
  late List<BannerModel> banners;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    banners = BlocProvider.of<CarouselHomeCubit>(context).carouselHome!;
    List<Widget> lstWidget = [];

    for (int i = 0; i < banners.length; i++) {
      lstWidget.add(
        Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                    imageUrl: 'https://albakr-ac.com/${banners[i].image}',
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Icon(Icons.access_alarm))),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black.withOpacity(0.2),
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
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.45,
                    child: Text(
                      'أصبح سهلا الآن وبين يديك فقط أطب ما تحتاجه ونصله إليك',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: size.width * 0.035,
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
              dotsCount: banners.length,
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
    );
  }
}
