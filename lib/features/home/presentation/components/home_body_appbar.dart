import 'package:e_commerce/models/homeModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constant/font_size.dart';
import '../../../../../constant/navigator.dart';
import '../../../screens/search/search.dart';

class HomeAppBar extends StatelessWidget {
  final HomeModel? home;
  const HomeAppBar({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return    Padding(
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
    );
  }
}
