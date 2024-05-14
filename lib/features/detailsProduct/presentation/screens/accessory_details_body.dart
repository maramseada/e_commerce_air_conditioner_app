import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/ordermodel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../Cubits/Images/image_cubit.dart';
import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/accessor_model.dart';
import '../../../../../widgets/button.dart';
import '../../../home/presentation/controllers/accessory/acessory_details_cubit.dart';
import '../../../home/presentation/controllers/accessory/acessory_details_state.dart';
import '../components/image_loader.dart';

import '../widgets/carouselDetails.dart';
import '../widgets/review.dart';

class AccessoryDetailsBody extends StatefulWidget {
  final int id;
  final AccessoryModel? Accessory;
  const AccessoryDetailsBody({super.key, required this.id, required this.Accessory});

  @override
  State<AccessoryDetailsBody> createState() => _AccessoryDetailsBodyState();
}

class _AccessoryDetailsBodyState extends State<AccessoryDetailsBody> {
  bool incrementAmount = false;

  final _api = Api();
  final cartApi = CartApi();
  bool isSelected = false;
  bool progress = false;
  List<String> errors = [];
  bool isAddingAccessory = false;
  int? addsId;
  bool isAddingProduct = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List imageUrls = [
      'https://albakr-ac.com/${widget.Accessory!.images![0]}',
      'https://albakr-ac.com/${widget.Accessory!.images![1]}',
      'https://albakr-ac.com/${widget.Accessory!.images![2]}',
      'https://albakr-ac.com/${widget.Accessory!.images![3]}',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child:




           SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    height: 380,
                    child: CarouselDetails(
                      images: imageUrls
                          .map(
                            (imageUrl) =>CachedNetworkImage(imageUrl: imageUrl,

                            )
                          )
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 5),
                  child: Text(
                    widget.Accessory!.name,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: size.width * 0.044,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 20,
                      initialRating: widget.Accessory!.totalRate!.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Color(0xFFD3A100),
                      ),
                      onRatingUpdate: (rating) {},
                      tapOnlyMode: true,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      '(${widget.Accessory!.totalRate})',
                      style: TextStyle(
                        color: const Color(0xFFD3A100),
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 10),
                  child: Text(
                    widget.Accessory!.description,
                    style: const TextStyle(
                      color: Color(0xFF8A8A8A),
                      fontFamily: 'Almarai',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.015),
                  child: Text(
                    ' ${widget.Accessory!.price} ر.س  ',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                      color: const Color(0xFFCA7009),
                    ),
                  ),
                ),
                // toto radio screen Accessory details
                widget.Accessory!.quantity < 5
                    ? Padding(
                        padding: EdgeInsets.only(right: size.width * 0.055, top: 20),
                        child: Text(
                          'متوفر عدد ${widget.Accessory!.quantity} قطع ! ',
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.bold,
                            color: secondColor,
                          ),
                        ))
                    : const SizedBox(),
                widget.Accessory!.quantity != 0
                    ? Column(children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'حدد الكمية المطلوبة',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.045,
                              fontFamily: 'Almarai',
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: size.width * 0.5,
                            height: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      BlocProvider.of<AccessoryDetailsCubit>(context).amountIncrease();
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.1,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: incrementAmount ? Color(0xFFEFF5F9) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: incrementAmount ? Colors.transparent : Color(0xB31D75B1),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  BlocProvider.of<AccessoryDetailsCubit>(context).amount.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.09,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      BlocProvider.of<AccessoryDetailsCubit>(context).amountDecrease();
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.1,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: incrementAmount ? Color(0xFFEFF5F9) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: incrementAmount ? Colors.transparent : Color(0xB31D75B1),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<AccessoryDetailsCubit>(context).addToCart(id: widget.Accessory!.id.toString());
                            },
                            child: Button(
                              text: 'إضافة إلى عربة التسوق',
                              inProgress: isAddingProduct,
                            ),
                          ),
                        ),
                      ])
                    : Container(
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        alignment: Alignment.center,
                        child: Text(
                          'المنتج غير متوفر',
                          style: TextStyle(
                            color: redColor,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                          ),
                        ),
                      ),

                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.04, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Color(0xFFD3A100),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        'تقييمات المنتج',
                        style: TextStyle(fontSize: size.width * 0.044, fontFamily: 'Almarai', fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.055, vertical: 10),
                  child: widget.Accessory!.reviews != null && widget.Accessory!.reviews!.isNotEmpty
                      ? Text(
                          'عرض لجميع التقييمات على هذا المنتج',
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontFamily: 'Almarai',
                          ),
                        )
                      : Text(
                          'لا يوجد بعد تقييمات على هذا المنتج ',
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontFamily: 'Almarai',
                          ),
                        ),
                ),
                widget.Accessory!.reviews != null && widget.Accessory!.reviews!.isNotEmpty
                    ? ReviewProduct(reviewsAccessory: widget.Accessory!.reviews)
                    : SizedBox(
                        height: 30,
                      ),
              ],
            ),
          ),


    );
  }


}
