import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/app_constants.dart';
import '../../../data/models/project.dart';

class OurProjectsListViewItem extends StatelessWidget {
  final Project project;
  const OurProjectsListViewItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: size.width * 0.1),
      width: size.width * 0.8,
      decoration: BoxDecoration(color: const Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 5),
              child: CachedNetworkImage(
                imageUrl: '${AppConstants.baseUrl}${project.image}',
              )),
          Container(
            width: size.width * 0.7,
            padding: EdgeInsets.only(right: size.width * 0.01, top: 10),
            child: Text(
              project.title,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveFontSize(context, fontSize: 18),
              ),
            ),
          ),
          Container(
            width: size.width * 0.7,
            padding: EdgeInsets.only(right: size.width * 0.01, top: 10),
            child: Text(
              'المدينة : ${project.location} ',
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: 'Almarai', fontSize: getResponsiveFontSize(context, fontSize: 17), fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: size.width * 0.7,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: 10),
            child: Text(
              'نوع التكييف : ${project.air_condition_type} ',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize: 16),
                fontWeight: FontWeight.w400,
                fontFamily: 'Almarai',
              ),
            ),
          )
        ],
      ),
    );
  }
}
