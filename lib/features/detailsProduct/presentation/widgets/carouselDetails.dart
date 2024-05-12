import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../../api/api.dart';

class CarouselDetails extends StatefulWidget {
  List images;
  CarouselDetails({super.key, required this.images});

  @override
  State<CarouselDetails> createState() => _CarouselDetailsState();
}

class _CarouselDetailsState extends State<CarouselDetails> {
  late CarouselController controller;
  int selectedIndex = 0;
  final _api = Api();


  final CarouselController _topCarouselController = CarouselController();
  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> LstWidget = [
      Stack(
        fit: StackFit.expand,
        children: [
       widget.images[0],
        ],
      ),

      Stack(
        fit: StackFit.expand,
        children: [
          widget.images[1],

        ],
      ),
      Stack(
        fit: StackFit.expand,
        children: [
          widget.images[2],
        ],
      ),
      Stack(
        fit: StackFit.expand,
        children: [
          widget.images[3] ,
        ],
      )
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 270,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: size.width * 0.018),
                  height: size.height * 0.35,
                  child: CarouselSlider(
                    carouselController: _topCarouselController,
                    items: LstWidget,
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 50,
                  right: 50,
                  child: DotsIndicator(
                    dotsCount: LstWidget.length,
                    position: selectedIndex,
                    onTap: (index) {
                      _topCarouselController.animateToPage(index.toInt());
                    },
                    decorator: DotsDecorator(
                      color: Color(0x62CA7009),
                      activeColor: Color(0xFFCA7009),
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

          Container(
            height: 70,
            alignment: Alignment.center,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = false; // Track whether the item is selected or not

                return GestureDetector(
                  onTap: () {
                    print('index ${index.toInt()}');
                    _topCarouselController.animateToPage(index);
                    // Update the isSelected state when tapped
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0), // Add margin for spacing
                    decoration: BoxDecoration(
                      color: index == selectedIndex ? Colors.transparent : Color(0xFFF4F4F4), // Border color based on selection
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: index == selectedIndex ? Colors.black : Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: size.width*0.18, child: widget.images[index],
                    )
                  ),
                );
              },
            ),
          )

          // Container(
          //   width: size.width * 0.6,
          //   child: CarouselSlider(
          //     carouselController: _topCarouselController,
          //     options: CarouselOptions(
          //       autoPlay: true,
          //       aspectRatio: 4.0,
          //       enlargeCenterPage: true,
          //       viewportFraction: 1.0 / 4.0, // Show exactly four items at a time
          //       onPageChanged: (index, reason) {
          //         _topCarouselController.animateToPage(index.toInt());
          //       },
          //       // Add the onTap callback to handle tap events
          //       onTap: (index) {
          //         // Perform your action when an item is tapped
          //         print('Item at index $index tapped!');
          //       },
          //     ),
          //     items: LstWidgett,
          //   ),
          // ),
        ],
      ),
    );
  }
}
