import 'package:e_commerce/models/ordermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/font_size.dart';
import '../../../../../models/accessor_model.dart';


class ReviewProduct extends StatelessWidget {
  final List<ReviewsModel>? reviews;
  final List<ReviewsAccessoryModel>? reviewsAccessory;

  ReviewProduct({Key? key, this.reviews, this.reviewsAccessory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (reviews != null && reviews!.isNotEmpty) {
      return Container(
        height: 350,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reviews!.length,
          itemBuilder: (BuildContext context, int index) {
            return buildReviewItem(reviews![index], size, context);
          },
        ),
      );
    } else if (reviewsAccessory != null && reviewsAccessory!.isNotEmpty) {
      return Container(
        height: 350,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reviewsAccessory!.length,
          itemBuilder: (BuildContext context, int index) {
            return buildReviewAccessoryItem(reviewsAccessory![index], size, context);
          },
        ),
      );
    } else {
      return SizedBox(); // Return an empty widget if both lists are null or empty
    }
  }

  Widget buildReviewItem(ReviewsModel review, Size size, BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03,top: 10),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/user.svg'),
                    SizedBox(width: size.width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Text(
                            '${review.user!.f_name} ${review.user!.l_name}',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize:getResponsiveFontSize(context, fontSize: 16), fontFamily: 'Almarai'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                     RatingBar.builder(
                      ignoreGestures: true,

                      itemSize: 20,
                      initialRating: review.rate.toDouble()?? 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Color(0xFFD3A100),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(width: size.width * 0.015),
                    Text(
                      '(${review.rate})',
                      style: TextStyle(
                        color: Color(0xFFD3A100),
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.bold,
                        fontSize:getResponsiveFontSize(context, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.018, top: 10),
              child: Text(
                "${review.comment}",
                style: TextStyle(fontFamily: 'Almarai', fontSize:getResponsiveFontSize(context, fontSize: 14), color: Color(0xFF7D7D7D)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildReviewAccessoryItem(ReviewsAccessoryModel review, Size size, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03,top: 10),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/user.svg'),
                    SizedBox(width: size.width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Text(
                            '${review.user!.f_name} ${review.user!.l_name}',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize:getResponsiveFontSize(context, fontSize: 16), fontFamily: 'Almarai'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [  RatingBar.builder(
                    ignoreGestures: true,

                    itemSize: 20,
                    initialRating: review.rate.toDouble()?? 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: Color(0xFFD3A100),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                    SizedBox(width: size.width * 0.015),
                    Text(
                      '(${review.rate})',
                      style: TextStyle(
                        color: Color(0xFFD3A100),
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.bold,
                        fontSize: getResponsiveFontSize(context, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.018, top: 10),
              child: Text(
                "${review.comment}",
                style: TextStyle(fontFamily: 'Almarai', fontSize: getResponsiveFontSize(context, fontSize: 14), color: Color(0xFF7D7D7D)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
