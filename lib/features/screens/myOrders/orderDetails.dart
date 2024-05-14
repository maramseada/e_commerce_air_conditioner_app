import 'package:e_commerce/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constant/images.dart';
import '../../../../../widgets/button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../api/orders_api.dart';
import '../../../models/ordermodel.dart';

class OrderDetails extends StatefulWidget {
  int id;
  OrderDetails({super.key, required this.id});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

//ordersDetails
class _OrderDetailsState extends State<OrderDetails> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool inProgress = false;
  final _api = OrdersApi();
  double? ratingProduct;
  int? rateInt;
  String? comment;
  String? accessoryComment;
  bool progress = false;
  List<TextEditingController> ratingControllers = [];
  List<TextEditingController> ratingControllersAdds = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  bool _dataLoaded = false; // Track whether data has been loaded from API
  OrderModel? order;

  String? accessoryId;
  String? orderId;
  @override
  void initState() {
    super.initState();
    _fetchData(); // Call the method to fetch data when widget is initialized
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  Future<void> _fetchData() async {
    try {
      order = await _api.ordersDetails(widget.id);
      setState(() {
        _dataLoaded = true;
        ratingControllers = List.generate(
          order!.orderProduct!.length,
          (index) => TextEditingController(),
        );
        ratingControllersAdds = List.generate(
          order!.accessoryProduct!.length,
          (index) => TextEditingController(),
        );
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
          ),
          title: Text(
            'تفاصيل الطلب',
            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
          ),
        ),
        body: SafeArea(
          child: _dataLoaded // Check if data has been loaded
              ? RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'رقم الطلب',
                                    style: TextStyle(
                                      color: grayColor,
                                      fontFamily: 'Almarai',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    '#${order!.orderNum}',
                                    style: TextStyle(
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
                                    order!.payDate ?? '',
                                    style: TextStyle(
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
                              Text(
                                'حالة الطلب',
                                style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w300, color: Color(0xFF2D2525)),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.brightness_1_sharp,
                                    size: 15,
                                    color: order!.status == 'delivered'
                                        ? Colors.red
                                        : order!.status == 'current'
                                            ? Colors.green
                                            : Colors.transparent, // Add a default color or handle this case
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  order!.status == 'current'
                                      ? Text(
                                          'طلب حالي',
                                          style: TextStyle(
                                            fontFamily: 'Almarai',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green,
                                          ),
                                        )
                                      : order!.status == 'delivered'
                                          ? Text(
                                              'طلب منتهي',
                                              style: TextStyle(
                                                fontFamily: 'Almarai',
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red,
                                              ),
                                            )
                                          : Text(
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
                            order!.orderProduct!.length,
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
                                        child: FutureBuilder<Widget>(
                                            future: _api.ImageHome(
                                              order!.orderProduct![index].product!.image,
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Container();
                                              } else if (snapshot.hasError) {
                                                return Text('Error: ${snapshot.error}');
                                              } else {
                                                final imageWidget = snapshot.data;
                                                return imageWidget != null
                                                    ? SizedBox(
                                                        child: imageWidget,
                                                      )
                                                    : SizedBox(); //
                                              }
                                            }),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order!.orderProduct![index].product!.name,
                                            style: TextStyle(
                                              fontFamily: 'Almarai',
                                              fontWeight: FontWeight.w700,
                                              fontSize: size.width * 0.035,
                                              color: Color(0xff25170B),
                                            ),
                                          ),
                                          Container(
                                            //   width: size.width * 0.2,
                                            height: 30,
                                            child: FutureBuilder<Widget>(
                                              future: _api.ImageHome(order!.orderProduct![index].product!.brand!.image),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return Container();
                                                } else if (snapshot.hasError) {
                                                  return Text('Error: ${snapshot.error}');
                                                } else {
                                                  final imageWidget = snapshot.data;
                                                  return imageWidget != null
                                                      ? Row(
                                                          mainAxisAlignment: MainAxisAlignment.start, // Align the row to the end (right)
                                                          children: [
                                                            imageWidget,
                                                          ],
                                                        )
                                                      : SizedBox(); //
                                                }
                                              },
                                            ),
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
                                            '${order!.orderProduct![index].product!.price} ر.س',
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
                                            ' X${order!.orderProduct![index].quantity}',
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
                                              order!.orderProduct![index].adds!.name,
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
                                          order!.orderProduct![index].adds!.price == '0.00'
                                              ? Text(
                                                  ' لا يوجد سعر إضافي',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: size.width * 0.033,
                                                      fontFamily: 'Almarai',
                                                      color: kPrimaryColor),
                                                )
                                              : Text(
                                                  order!.orderProduct![index].adds!.price,
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
                                  order!.status == 'current'
                                      ? Container()
                                      : order!.status == 'delivered'?   Padding(
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
                                        order!.status == 'current'
                                            ? Container()
                                            : order!.status == 'delivered'
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
                                                            orderId = order!.orderProduct![index].productId.toString();
                                                            print('orderId$orderId');
                                                          });
                                                          addReview(index);
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
                            order!.accessoryProduct!.length,
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
                                          child: FutureBuilder<Widget>(
                                              future: _api.ImageHome(
                                                order!.accessoryProduct![index].accessory!.image,
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return Container();
                                                } else if (snapshot.hasError) {
                                                  return Text('Error: ${snapshot.error}');
                                                } else {
                                                  final imageWidget = snapshot.data;
                                                  return imageWidget != null
                                                      ? SizedBox(
                                                          child: imageWidget,
                                                        )
                                                      : SizedBox(); //
                                                }
                                              }),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.5,
                                          child: Text(
                                            order!.accessoryProduct![index].accessory!.name,
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
                                              '${order!.accessoryProduct![index].accessory!.price} ر.س',
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
                                              ' X${order!.accessoryProduct![index].accessory!.quantity}',
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
                                          order!.status == 'current'
                                              ? Container()
                                              : order!.status == 'delivered'
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
                                                              accessoryId = order!.accessoryProduct![index].accessoryId.toString();

                                                              print('accessoryId$accessoryId');
                                                            });
                                                            addReviewExtra(index);
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
                                            '${order!.address!.area!.name}',
                                            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                                            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                          ),
                                          Text('  , '),
                                          Text(
                                            '${order!.address!.city!.name}',
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
                                          '${order!.address!.town!.name}',
                                          style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.03),
                                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                        ),
                                        Text('  , '),
                                        Text(
                                          '${order!.address!.buildingNum}',
                                          style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.03),
                                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                        ),
                                        Text('  , '),
                                        Text(
                                          '${order!.address!.street}',
                                          style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.03),
                                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                        ),
                                        Text('  , '),
                                        Text(
                                          '${order!.address!.landmark}',
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
                                    'XXXX XXXX XXXX ${order!.card}',
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
                                              order!.grandTotal,
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
                                              order!.discountValue,
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
                                              order!.addedValue,
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
                                    order!.grandTotal,
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
                        order!.status == 'current'
                            ? Container()
                            : order!.status == 'delivered'
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
                )
              : Center(
                  child: CircularProgressIndicator(), // Show loading indicator until data is loaded
                ),
        ),
      ),
    );
  }

  void addReview(
    int index,
  ) async {
    setState(() {
      progress = true;
      comment = ratingControllers[index].text;

    });
    print('orderrrrrrrrrrrrriddddddddddd$orderId');
    print('orderrrrrrrrrrrrriddddddddddd$comment');
    print('orderrrrrrrrrrrrriddddddddddd$ratingProduct');
    print('orderrrrrrrrrrrrriddddddddddd$accessoryComment');
    try {
      String reviewComment = '';
      String reviewCommentAccessory = '';

      // Concatenate comments from both fields
      // if (comment != null && comment!.isNotEmpty) {
      //   reviewComment += comment! + ' '; // Add comment from product field
      // }
      // if (accessoryComment != null && accessoryComment!.isNotEmpty) {
      //   reviewCommentAccessory += accessoryComment!; // Add comment from accessory field
      // }

      Map<String, dynamic>? response = await _api.addReview(
        comment?? '', // Trim to remove any leading/trailing spaces
        rateInt == null || rateInt == 0.0 ? '3' : rateInt.toString(),
        orderId ?? '',
       '',
      );



      if (response != null && response['status'] == 200) {
        SnackBar snackBar = SnackBar(
          content: Text(
            'Review Added Successfully',
            style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Review added');
        ratingControllers[index].text = '';
      } else {
        if (response != null && response['message'] != null) {
          setState(() {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
          });
        }
      }
    } catch (e) {
      print('Network Error: $e');
      setState(() {
        errors = ['Network error occurred. Please check your connection.'];
      });
    } finally {
      setState(() {
        progress = false;
      });
    }
  }

  void addReviewExtra( int index) async {
    setState(() {
      progress = true;
      accessoryComment = ratingControllersAdds[index].text; // Retrieve text from the appropriate controller
    });
    print('accessory id=========== $accessoryId');
    print('accessory  comment=======$accessoryComment');
    print('accessory rating ===========$ratingProduct');

    try {
      Map<String, dynamic>? response = await _api.addReview(
        accessoryComment ?? '',
        rateInt == null || rateInt == 0.0 ? '3' : rateInt.toString(),
        '',accessoryId?? '',
      );

      if (response != null && response['status'] == 200) {
        SnackBar snackBar = SnackBar(
          content: Text(
            'Review Added Successfully',
            style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Review added accessoryy ');
        ratingControllersAdds[index].text = '';
      } else {
        if (response != null && response['message'] != null) {
          setState(() {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
          });
        }
      }
    } catch (e) {
      print('Network Error: $e');
      setState(() {
        errors = ['Network error occurred. Please check your connection.'];
      });
    } finally {
      setState(() {
        progress = false;
      });
    }
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
