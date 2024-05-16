import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constant/app_constants.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/ordermodel.dart';

class OrderDetailsBody extends StatefulWidget {
 final OrderModel order;

  const OrderDetailsBody({super.key, required this.order});

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  bool inProgress = false;
  double? ratingProduct;
  int? rateInt;
  String? comment;
  String? accessoryComment;
  List<TextEditingController> ratingControllers = [];
  List<TextEditingController> ratingControllersAdds = [];

  String? accessoryId;
  String? orderId;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSpinAnimation() {
    _controller.forward(from: 0.0);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

  return
      RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'رقم الطلب',
                          style: TextStyle(
                            color: grayColor,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '#${widget.order.orderNum}',
                          style: const TextStyle(
                            fontFamily: 'Almarai',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          ' تاريخ ووقت الطلب',
                          style: TextStyle(
                            color: grayColor,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          widget.order.payDate ?? '',
                          style: const TextStyle(
                            fontFamily: 'Almarai',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: paleGrayColor, borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'حالة الطلب',
                      style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, color: Color(0xFF2D2525)),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.brightness_1_sharp,
                          size: 15,
                          color: widget.order.status == 'delivered'
                              ? Colors.red
                              : widget.order.status == 'current'
                              ? Colors.green
                              : Colors.transparent, // Add a default color or handle this case
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        widget.order.status == 'current'
                            ? const Text(
                          'طلب حالي',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        )
                            : widget.order.status == 'delivered'
                            ? const Text(
                          'طلب منتهي',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                        )
                            : const Text(
                          'Unknown Status', // Handle unknown status here
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w700,
                            color: Colors.black, // Choose appropriate color
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المنتجات',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.046, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'المنتجات المضافة إلى الطلب',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.03, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Column(
                children: List.generate(
                  widget.order.orderProduct!.length,
                      (index) => Container(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.03),
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.04),
                    // height: size.height * 0.45,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.13), // Shadow color
                            spreadRadius: 10, // How much the shadow should spread
                            blurRadius: 20, // How soft the shadow should be
                            offset: const Offset(0, 3), // Changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 50,
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.05), // Shadow color
                                      spreadRadius: 1, // How much the shadow should spread
                                      blurRadius: 10, // How soft the shadow should be
                                      offset: const Offset(0, 5), // Changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CachedNetworkImage(imageUrl: '${AppConstants.baseUrl}${widget.order.orderProduct![index].product!.image}',)


                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.orderProduct![index].product!.name,
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.035,
                                    color: Color(0xff25170B),
                                  ),
                                ),
                                SizedBox(
                                    height: 30,
                                    child: CachedNetworkImage(imageUrl: '${AppConstants.baseUrl}${widget.order.orderProduct![index].product!.brand!.image}',)

                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'السعر',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: size.width * 0.033,
                                    fontFamily: 'Almarai',
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.017,
                                ),
                                Text(
                                  '${widget.order.orderProduct![index].product!.price} ر.س',
                                  style: TextStyle(
                                    fontSize: size.width * 0.038,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Almarai',
                                    color: secondColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' الكمية المطلوبة',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.035,
                                    fontFamily: 'Almarai',
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.014,
                                ),
                                Text(
                                  ' X${widget.order.orderProduct![index].quantity}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.05,
                                    fontFamily: 'Almarai',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 0.27,
                                  child: Text(
                                    widget.order.orderProduct![index].adds!.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: size.width * 0.035,
                                        fontFamily: 'Almarai',
                                        color: kPrimaryColor),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.018,
                                ),
                                widget.order.orderProduct![index].adds!.price == '0.00'
                                    ? Text(
                                  ' لا يوجد سعر إضافي',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.033,
                                      fontFamily: 'Almarai',
                                      color: kPrimaryColor),
                                )
                                    : Text(
                                  widget.order.orderProduct![index].adds!.price,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.033,
                                      fontFamily: 'Almarai',
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        widget.order.status == 'current'
                            ? Container()
                            : widget.order.status == 'delivered'?   Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            height: 2,
                          ),
                        ):Container(),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.order.status == 'current'
                                  ? Container()
                                  : widget.order.status == 'delivered'
                                  ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.035,
                                  ),
                                  child: Column(children: [
                                    Text(
                                      'قم بتقييم هذا المنتج',
                                      style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        fontFamily: 'Almarai',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: size.width * 0.035),
                                      child: RatingBar.builder(
                                        initialRating: 3, // Set initial rating to 1
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 22,
                                        tapOnlyMode: false, // Allow tapping to change value
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        itemBuilder: (context, _) => const FaIcon(
                                          FontAwesomeIcons.solidStar,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            ratingProduct = rating;
                                            rateInt = ratingProduct?.toInt();
                                            print(rating); // Update the FormField value when the rating changes
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        left: size.width * 0.035,
                                        right: size.width * 0.035,
                                      ),
                                      child: TextFormField(
                                        maxLines: 2,
                                        textAlign: TextAlign.right,
                                        onChanged: (value) {
                                          comment = value;
                                        },
                                        controller:
                                        ratingControllers[index], // Use the controller corresponding to the current index
                                        decoration: InputDecoration(
                                          hintText: ' اكتب رأيك بهذا المنتج',
                                          hintStyle: TextStyle(
                                            color: grayColor,
                                            fontSize: size.width * 0.035,
                                            fontFamily: 'Almarai',
                                            fontWeight: FontWeight.w300,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFF7F7F7),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFF7F7F7),
                                            ),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFF7F7F7),
                                            ),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          orderId = widget.order.orderProduct![index].productId.toString();
                                          print('orderId$orderId');
                                        });
                                        //   addReview(index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: size.width * 0.035,
                                        ),
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(color: secondColor, borderRadius: BorderRadius.circular(30)),
                                        child: Center(
                                          child: Text(
                                            'إرسال التقييم',
                                            style: TextStyle(
                                                fontFamily: 'Almarai',
                                                color: Colors.white,
                                                fontSize: size.width * 0.045,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]))
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: List.generate(
                  widget.order.accessoryProduct!.length,
                      (index) => Container(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.03),
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.04),
                    // height: size.height * 0.45,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.13), // Shadow color
                            spreadRadius: 10, // How much the shadow should spread
                            blurRadius: 20, // How soft the shadow should be
                            offset: Offset(0, 3), // Changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: Container(
                      height: 410,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  height: 50,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.05), // Shadow color
                                        spreadRadius: 1, // How much the shadow should spread
                                        blurRadius: 10, // How soft the shadow should be
                                        offset: Offset(0, 5), // Changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CachedNetworkImage(imageUrl: '${AppConstants.baseUrl}${widget.order.accessoryProduct![index].accessory!.image}',)
                              ),
                              SizedBox(
                                width: size.width * 0.5,
                                child: Text(
                                  widget.order.accessoryProduct![index].accessory!.name,
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.035,
                                    color: Color(0xff25170B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'السعر',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.033,
                                      fontFamily: 'Almarai',
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.017,
                                  ),
                                  Text(
                                    '${widget.order.accessoryProduct![index].accessory!.price} ر.س',
                                    style: TextStyle(
                                      fontSize: size.width * 0.038,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Almarai',
                                      color: secondColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' الكمية المطلوبة',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.width * 0.035,
                                      fontFamily: 'Almarai',
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.014,
                                  ),
                                  Text(
                                    ' X${widget.order.accessoryProduct![index].accessory!.quantity}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05,
                                      fontFamily: 'Almarai',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              height: 2,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.order.status == 'current'
                                    ? Container()
                                    : widget.order.status == 'delivered'
                                    ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.035,
                                    ),
                                    child: Column(children: [
                                      Text(
                                        'قم بتقييم هذا المنتج',
                                        style: TextStyle(
                                          fontSize: size.width * 0.035,
                                          fontFamily: 'Almarai',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: size.width * 0.035),
                                        child: RatingBar.builder(
                                          initialRating: 3, // Set initial rating to 1
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemSize: 22,
                                          tapOnlyMode: false, // Allow tapping to change value
                                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                          itemBuilder: (context, _) => FaIcon(
                                            FontAwesomeIcons.solidStar,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              ratingProduct = rating;
                                              rateInt = ratingProduct?.toInt();
                                              print(rating); // Update the FormField value when the rating changes
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          left: size.width * 0.035,
                                          right: size.width * 0.035,
                                        ),
                                        child: TextFormField(
                                          maxLines: 2,
                                          textAlign: TextAlign.right,
                                          onChanged: (value) {
                                            accessoryComment = value;
                                          },
                                          controller:
                                          ratingControllersAdds[index], // Use the controller corresponding to the current index
                                          decoration: InputDecoration(
                                            hintText: ' اكتب رأيك بهذا المنتج',
                                            hintStyle: TextStyle(
                                              color: grayColor,
                                              fontSize: size.width * 0.035,
                                              fontFamily: 'Almarai',
                                              fontWeight: FontWeight.w300,
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xFFF7F7F7),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF7F7F7),
                                              ),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF7F7F7),
                                              ),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            accessoryId = widget.order.accessoryProduct![index].accessoryId.toString();

                                            print('accessoryId$accessoryId');
                                          });
                                          // addReviewExtra(index);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: size.width * 0.035,
                                            ),
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(color: secondColor, borderRadius: BorderRadius.circular(30)),
                                            child: Center(
                                              child: Text(
                                                'إرسال التقييم',
                                                style: TextStyle(
                                                    fontFamily: 'Almarai',
                                                    color: Colors.white,
                                                    fontSize: size.width * 0.045,
                                                    fontWeight: FontWeight.w300),
                                              ),
                                            )),
                                      )
                                    ]))
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: size.width * 0.04, top: size.height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عنوان التوصيل',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.046, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'عنوان توصيل الطلب',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.03, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(color: paleGrayColor, borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/locationicon.svg',
                      width: 40,
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: size.width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.address!.area!.name,
                                  style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                                  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                ),
                                const Text('  , '),
                                Text(
                                  widget.order.address!.city!.name,
                                  style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                                  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                ),
                              ],
                            )),
                        SizedBox(
                          width: size.width * 0.6,
                          child: Row(
                            children: [
                              Text(
                                widget.order.address!.town!.name,
                                style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.03),
                                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                              ),
                              const Text('  , '),
                              Text(
                                widget.order.address!.buildingNum,
                                style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.03),
                                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                              ),
                              const Text('  , '),
                              Text(
                                widget.order.address!.street,
                                style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.03),
                                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                              ),
                              const Text('  , '),
                              Text(
                                widget.order.address!.landmark,
                                style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.03),
                                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' الدفع',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.046, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'بيانات طريقة الدفع',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.03, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(color: paleGrayColor, borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/card.svg',
                      width: 40,
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ahmed **** **** osad',
                          style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                        ),
                        Text(
                          'XXXX XXXX XXXX ${widget.order.card}',
                          style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.036),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تفاصيل الدفع',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.046, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'بيانات فاتورة الدفع للطلب',
                      style: TextStyle(
                          fontFamily: 'Almarai', color: Color(0xFF2D2525), fontSize: size.width * 0.03, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: size.width * 0.03, right: size.width * 0.03),
                height: 170,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.024, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              ' إجمالي المنتجات',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.035),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'قيمة الخصم',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.035),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    ' قيمة الضريبة المضافة',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.035),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '14%',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.035),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  Text(
                                    widget.order.grandTotal,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'ر.س',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.03),
                                  ),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    widget.order.discountValue,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'ر.س',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.03),
                                  ),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    widget.order.addedValue,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'ر.س',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.03),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                ),
                child: Divider(
                  color: Color(0x3D707070),
                  height: 2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: size.width * 0.07, right: size.width * 0.07),
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        ' إجمالي الطلب',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, fontSize: size.width * 0.038),
                      ),
                    ),
                    Container(
                        child: Row(
                          children: [
                            Text(
                              widget.order.grandTotal,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Almarai', fontWeight: FontWeight.bold, color: secondColor, fontSize: size.width * 0.045),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ر.س',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Almarai', color: secondColor, fontWeight: FontWeight.w300, fontSize: size.width * 0.035),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              widget.order.status == 'current'
                  ? Container()
                  : widget.order.status == 'delivered'
                  ? GestureDetector(
                onTap: () {
                  _startSpinAnimation();
                },
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.08,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  decoration: ShapeDecoration(
                    color: inProgress ? kPrimaryColorDark : kPrimaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
                  ),
                  child: Center(
                    child: inProgress
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (BuildContext context, Widget? child) {
                            return Transform(
                              transform: Matrix4.rotationZ(_controller.value * 2 * 3.1415),
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/rotate-right.png',
                                width: size.width * 0.09,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'إعادة الطلب مرة أخرى',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.05,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/rotate-right.png',
                          width: size.width * 0.09,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'إعادة الطلب مرة أخرى',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.05,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  : Container(),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      );
  }
  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
