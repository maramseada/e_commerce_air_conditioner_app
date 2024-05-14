import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/app_constants.dart';
import '../../../../../core/constant/colors.dart';
import '../../../data/models/works.dart';

class WorkDetailsBodyItem extends StatelessWidget {
  final Works work;
  const WorkDetailsBodyItem({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Container(
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      margin: const EdgeInsets.symmetric(vertical:10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child:CachedNetworkImage(
                imageUrl: '${AppConstants.baseUrl}${work.image}',
              )
          ),
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أعمال الــ ${work.type}',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.04,
                    color: kPrimaryColor,
                  ),
                ),
                Text(
                  work.description,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
