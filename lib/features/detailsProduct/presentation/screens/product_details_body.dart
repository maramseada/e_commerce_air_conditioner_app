import 'package:e_commerce/Cubits/Images/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/add_to_cart_product_contoller.dart';
import '../controller/cart_product_cubit.dart';
import '../../../../../api/api.dart';

import '../../../../../constant/colors.dart';
import '../../../../../models/ordermodel.dart';
import '../controller/product/product_details_cubit.dart';
import '../widgets/Radio.dart';
import '../widgets/carouselDetails.dart';
import '../components/image_loader.dart';
import '../widgets/review.dart';

class ProductDetailsBody extends StatefulWidget {
  ProductsModel? product;
  int? id;
  ProductDetailsBody({super.key, required this.product, required this.id});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  String? image;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool incrementAmount = false;
    final _api = Api();

    int addsId = 1;
    void handleItemSelected(int value) {
      setState(() {
        BlocProvider.of<CartProductDetailsCubit>(context).addsId = value;
      });
    }

    List<String> imageUrls = [
      if (widget.product!.images.isNotEmpty) widget.product!.images[0] else widget.product!.image,
      if (widget.product!.images.length > 1) widget.product!.images[1] else widget.product!.image,
      if (widget.product!.images.length > 2) widget.product!.images[2] else widget.product!.image,
      if (widget.product!.images.length > 3) widget.product!.images[3] else widget.product!.image,
    ];

    bool isAddingProduct = false;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    height: 380,
                    child: CarouselDetails(
                        // Generate BlocBuilders for each product image with different indices
                        images:imageUrls
                            .map(
                              (imageUrl) => BlocProvider(
                            create: (context) => ImagesCubit(Api()), // Initialize ImagesCubit with your API
                            child: ImageLoader(imageUrl: imageUrl),
                          ),
                        )
                            .toList(),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 5),
                  child: Text(
                    widget.product!.name,
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
                    widget.product!.brand != null
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            width: 110,
                            child: FutureBuilder<Widget>(
                                future: _api.getImage(widget.product!.brand!.image),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    final imageWidget = snapshot.data;
                                    return imageWidget != null
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: imageWidget,
                                          )
                                        : SizedBox(); //
                                  }
                                }),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.018,
                          )),
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 20,
                      initialRating: widget.product!.totalRate.toDouble(),
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
                      '(${widget.product!.totalRate})',
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
                    widget.product!.description,
                    style: const TextStyle(
                      color: Color(0xFF8A8A8A),
                      fontFamily: 'Almarai',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.015),
                  child: Text(
                    ' ${widget.product!.price} ر.س  ',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                      color: const Color(0xFFCA7009),
                    ),
                  ),
                ),

                RadioScreen(onItemSelected: handleItemSelected),

                widget.product!.quantity < 5
                    ? Padding(
                        padding: EdgeInsets.only(right: size.width * 0.055, top: 20),
                        child: Text(
                          'متوفر عدد ${widget.product!.quantity} قطع ! ',
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.bold,
                            color: secondColor,
                          ),
                        ))
                    : const SizedBox(),
                widget.product!.quantity != 0
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
                                    BlocProvider.of<ProductDetailsCubit>(context).amountIncrease();
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
                                  BlocProvider.of<ProductDetailsCubit>(context).amount.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.09,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<ProductDetailsCubit>(context).amountDecrease();
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
                              BlocProvider.of<CartProductDetailsCubit>(context).addToCart(
                                id: widget.id.toString(), amount:  BlocProvider.of<ProductDetailsCubit>(context).amount, context: context,
                              );


                            },
                            child: const AddToCartProduct()

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
                      const FaIcon(
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
                  child: widget.product!.reviews != null && widget.product!.reviews!.isNotEmpty
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
                widget.product!.reviews != null && widget.product!.reviews!.isNotEmpty
                    ? ReviewProduct(reviews: widget.product!.reviews)
                    : const SizedBox(
                        height: 10,
                      ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
