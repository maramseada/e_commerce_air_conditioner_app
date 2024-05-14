import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constant/app_constants.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/font_size.dart';
import '../../../../../core/constant/navigator.dart';
import '../../../../screens/request_prise/request_prise.dart';
import '../../../data/models/works.dart';

class OurWorkListItem extends StatelessWidget {
  final Works work;
  const OurWorkListItem({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffF6F6F6),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: '${AppConstants.baseUrl}${work.image}',
              )),
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
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(

                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        navigateTo(context, RequestPrice());
                      },
                      child: Container(
                        width: size.width * 0.7,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kPrimaryColor,
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add, color: Colors.white, size: 25),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'طلب عرض سعر',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getResponsiveFontSize(context, fontSize: 20),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
