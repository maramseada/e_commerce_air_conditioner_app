import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../models/social_media.dart';

class SocialMediaBody extends StatelessWidget {
  final List<SocialMediaModel> socialMedia;

  const SocialMediaBody({super.key, required this.socialMedia});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Text(
            'تابعنا من خلال الروابط التالية',
            style: TextStyle(color: Color(0xFF9C9C9C), fontFamily: 'Almarai', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(socialMedia[3].url!));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SvgPicture.asset(
                    'assets/images/Group 176435.svg',
                    width: 50,
                    height: 50,
                    // Adjust the fit as needed
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(socialMedia[2].url!));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SvgPicture.asset(
                    'assets/images/Group 176436.svg',
                    width: 50,
                    height: 50,
                    // Adjust the fit as needed
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(socialMedia[0].url!));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SvgPicture.asset(
                    'assets/images/Group 176437.svg',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(socialMedia[4].url!));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SvgPicture.asset(
                    'assets/images/Group 176438.svg',
                    width: 50,
                    height: 50,
                    // Adjust the fit as needed
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(socialMedia[1].url!));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SvgPicture.asset(
                    'assets/images/Group 176439.svg',
                    width: 50,
                    height: 50,
                    // Adjust the fit as needed
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
