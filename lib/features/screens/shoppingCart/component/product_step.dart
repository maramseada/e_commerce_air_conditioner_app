

import 'package:e_commerce/features/screens/shoppingCart/component/productsCart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../api/cart_api.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/images.dart';
import '../../../../models/cart_model.dart';
import '../../../detailsProduct/presentation/widgets/Radio.dart';

class ProductStep extends StatefulWidget {
  const ProductStep({
    Key? key,
    required this.onNextStep,
    this.formKey,
    this.isActive = false,
  }) : super(key: key);

  final VoidCallback onNextStep;
  final bool isActive;
  final formKey;

  @override
  State<ProductStep> createState() => _ProductStepState();
}

class _ProductStepState extends State<ProductStep> {
  bool incrementAmount = false;
  CartApi _api = CartApi();
  late int amount;
  CartModel? data;
  bool isUpdatingProduct = false;
  bool isUpdatingAccessory= false;
  List<String> errors = [];
  int? addsId;
  int? amountChanging;
  String? amountString;
  int? amountAccessoryChanging;
  late int amountAccesssory;
  String? amountAccessoryString;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: amountChanging == 0
          ? FutureBuilder(
        key: _refreshIndicatorKey, // Add key here
        future: _api.getCart(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            return Container();
          } else {
            data = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                      height: size.height*0.3,
                      margin: EdgeInsets.only(top: size.height * 0.03, bottom: 20, left: 10, right: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.06),
                            spreadRadius: 10,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data!.cartProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                amount = data!.cartProducts[index].quantity; // Initialize amount with the initial value
                                void handleItemSelected(int value) {
                                  setState(() {
                                    addsId = value;
                                    updateProduct(index);
                                  });
                                }
                                void handleAmountChange(int value) {
                                  setState(() {
                                    amountChanging = value;
                                    updateProduct(index);
                                  });
                                }
                                return Container(
                                  height: 360,
                                  child: Column(
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: size.width * 0.3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.15), // Shadow color
                                                  spreadRadius: 10, // How much the shadow should spread
                                                  blurRadius: 10, // How soft the shadow should be
                                                  offset: Offset(0, 5), // Changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: FutureBuilder<Widget>(
                                                future: _api.getImage(data!.cartProducts[index].product.mainImage),
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
                                                data!.cartProducts[index].product.name,
                                                style: TextStyle(
                                                  fontFamily: 'Almarai',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: size.width * 0.035,
                                                  color: Color(0xff25170B),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              SizedBox(
                                                width: 60,
                                                height: 40,
                                                child: FutureBuilder<Widget>(
                                                    future: _api.getImage(data!.cartProducts[index].product.brand.image),
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

                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      RadioScreen(selectedIndex: data!.cartProducts[index].add.id, onItemSelected: handleItemSelected,),
                                      SizedBox(
                                        height: 20,
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
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: size.width * 0.042,
                                                  fontFamily: 'Almarai',
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                '${data!.cartProducts[index].product.price} ر.س',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.05,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Almarai',
                                                  color: Color(0xFFCA7009),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            color: Color(0xffEAEAEA),
                                            height: size.height * 0.08,
                                            width: 2,
                                          ),
                                          ProductsCart(amountProduct: data!.cartProducts[index].quantity,
                                            maxAmount: data!.cartProducts[index].product.quantity,
                                            onAmountChange: handleAmountChange,),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                                        child: Divider(
                                          height: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data!.cartAccessories.length,
                              itemBuilder: (BuildContext context, int index) {
                                amountAccesssory = data!.cartAccessories[index].quantity; // Initialize amount with the initial value
                                void handleAmountAccessoryChange(int value) {
                                  setState(() {
                                    amountAccessoryChanging = value;
                                    updateAccessory(index);
                                  });
                                }
                                return Container(
                                  height: 230,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: size.width * 0.3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.15), // Shadow color
                                                  spreadRadius: 10, // How much the shadow should spread
                                                  blurRadius: 10, // How soft the shadow should be
                                                  offset: Offset(0, 5), // Changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: FutureBuilder<Widget>(
                                                future: _api.getImage(data!.cartAccessories[index].accessory.image),
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
                                              SizedBox(
                                                width: size.width * 0.5,
                                                child: Text(
                                                  data!.cartAccessories[index].accessory.name,
                                                  style: TextStyle(
                                                    fontFamily: 'Almarai',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: size.width * 0.035,
                                                    color: Color(0xff25170B),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'السعر',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: size.width * 0.042,
                                                  fontFamily: 'Almarai',
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                '${data!.cartAccessories[index].accessory.price } ر.س',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.05,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Almarai',
                                                  color: Color(0xFFCA7009),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            color: Color(0xffEAEAEA),
                                            height: size.height * 0.08,
                                            width: 2,
                                          ),
                                          ProductsCart(amountProduct: data!.cartAccessories[index].quantity,
                                            maxAmount: data!.cartAccessories[index].accessory.quantity,
                                            onAmountChange: handleAmountAccessoryChange,),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                                        child: Divider(
                                          height: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.039),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'إجمالي الطلب',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.042,
                                fontFamily: 'Almarai',
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              '${data!.total} ر.س',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Almarai',
                                color: Color(0xFFCA7009),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _nextStep,
                          child: Container(
                            width: size.width * 0.42,
                            height: 60,
                            decoration: ShapeDecoration(
                              color: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'التالي',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.05,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                Image.asset(
                                  arrowL,
                                  width: size.width * 0.08,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            );
          }
        },      )
          : RefreshIndicator(
        key: _refreshIndicatorKey, // Same key here
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 500)); // Simulate a delay
          setState(() {}); // Trigger rebuild
        },
        child:  FutureBuilder(
          future: _api.getCart(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.data == null) {
              return Container();
            } else {
              data = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                        height: 300,
                        margin: EdgeInsets.only(top: size.height * 0.03, bottom: 20, left: 10, right: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.06),
                              spreadRadius: 10,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data!.cartProducts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  amount = data!.cartProducts[index].quantity; // Initialize amount with the initial value
                                  void handleItemSelected(int value) {
                                    setState(() {
                                      addsId = value;
                                      updateProduct(index);
                                    });
                                  }
                                  void handleAmountChange(int value) {
                                    setState(() {
                                      amountChanging = value;
                                      updateProduct(index);
                                    });
                                  }
                                  return Container(
                                    height: 360,
                                    child: Column(
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: size.width * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.15), // Shadow color
                                                    spreadRadius: 10, // How much the shadow should spread
                                                    blurRadius: 10, // How soft the shadow should be
                                                    offset: Offset(0, 5), // Changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: FutureBuilder<Widget>(
                                                  future: _api.getImage(data!.cartProducts[index].product.mainImage),
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
                                                  data!.cartProducts[index].product.name,
                                                  style: TextStyle(
                                                    fontFamily: 'Almarai',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: size.width * 0.035,
                                                    color: Color(0xff25170B),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                SizedBox(
                                                  width: 60,
                                                  height: 40,
                                                  child: FutureBuilder<Widget>(
                                                      future: _api.getImage(data!.cartProducts[index].product.brand.image),
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
                                                              : const SizedBox(); //
                                                        }
                                                      }),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        RadioScreen(selectedIndex: data!.cartProducts[index].add.id, onItemSelected: handleItemSelected,),
                                        SizedBox(
                                          height: 20,
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
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: size.width * 0.042,
                                                    fontFamily: 'Almarai',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                Text(
                                                  '${data!.cartProducts[index].product.price} ر.س',
                                                  style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Almarai',
                                                    color: Color(0xFFCA7009),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              color: Color(0xffEAEAEA),
                                              height: size.height * 0.08,
                                              width: 2,
                                            ),
                                            ProductsCart(amountProduct: data!.cartProducts[index].quantity,
                                              maxAmount: data!.cartProducts[index].product.quantity,
                                              onAmountChange: handleAmountChange,),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data!.cartAccessories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  amountAccesssory = data!.cartAccessories[index].quantity; // Initialize amount with the initial value
                                  void handleAmountAccessoryChange(int value) {
                                    setState(() {
                                      amountAccessoryChanging = value;
                                      updateAccessory(index);
                                    });
                                  }
                                  return Container(
                                    height: 230,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: size.width * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.15), // Shadow color
                                                    spreadRadius: 10, // How much the shadow should spread
                                                    blurRadius: 10, // How soft the shadow should be
                                                    offset: Offset(0, 5), // Changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: FutureBuilder<Widget>(
                                                  future: _api.getImage(data!.cartAccessories[index].accessory.image),
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
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: Text(
                                                    data!.cartAccessories[index].accessory.name,
                                                    style: TextStyle(
                                                      fontFamily: 'Almarai',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: size.width * 0.035,
                                                      color: Color(0xff25170B),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'السعر',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: size.width * 0.042,
                                                    fontFamily: 'Almarai',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                Text(
                                                  '${data!.cartAccessories[index].accessory.price } ر.س',
                                                  style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Almarai',
                                                    color: Color(0xFFCA7009),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              color: Color(0xffEAEAEA),
                                              height: size.height * 0.08,
                                              width: 2,
                                            ),
                                            ProductsCart(amountProduct: data!.cartAccessories[index].quantity,
                                              maxAmount: data!.cartAccessories[index].accessory.quantity,
                                              onAmountChange: handleAmountAccessoryChange,),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.039),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'إجمالي الطلب',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.042,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Text(
                                '${data!.total} ر.س',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Almarai',
                                  color: Color(0xFFCA7009),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: _nextStep,
                            child: Container(
                              width: size.width * 0.42,
                              height: 60,
                              decoration: ShapeDecoration(
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'التالي',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 0.05,
                                      fontFamily: 'Almarai',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  Image.asset(
                                    arrowL,
                                    width: size.width * 0.08,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              );
            }
          },        ),
      ),
    );
  }

  void _nextStep() {
    widget.onNextStep();
  }

  void updateAccessory(int index) async {
    setState(() {
      isUpdatingAccessory = true;
      // Set default values for amountString and addsId if they are null
      amountAccessoryString = amountAccessoryChanging?.toString() ?? data!.cartAccessories[index].quantity.toString();
    });

    try {
      print('Product ID: ${data!.cartAccessories[index].id}');
      print('Amount String: $amountAccessoryString');

      // Call the API with the updated values
      Map<String, dynamic>? response = await _api.updateAccessory(
        data!.cartAccessories[index].id.toString(),
        amountAccessoryString!,
      );

      // Handle the API response
      if (response != null && response['status'] == 200) {
        print('Product updated successfully');
      } else {
        // Handle error response
        setState(() {
          if (response != null && response['message'] != null) {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
          }
        });
      }
    } catch (e, stackTrace) {
      print('Error updating product: $e');
      print(stackTrace);
      // Handle the error gracefully
      setState(() {
        errors = ['Error updating product. Please try again.'];
      });
    } finally {
      setState(() {
        isUpdatingAccessory = false;
      });
    }
  }
  void updateProduct(int index) async {
    setState(() {
      isUpdatingProduct = true;
      // Set default values for amountString and addsId if they are null
      amountString = amountChanging?.toString() ?? data!.cartProducts[index].quantity.toString();
      addsId ??= data!.cartProducts[index].add.id; // Provide a default value if addsId is null
    });

    try {
      print('Product ID: ${data!.cartProducts[index].id}');
      print('Amount String: $amountString');
      print('Adds ID: $addsId');

      // Call the API with the updated values
      Map<String, dynamic>? response = await _api.updateProduct(
        data!.cartProducts[index].id.toString(),
        amountString!,
        addsId.toString(),
      );

      // Handle the API response
      if (response != null && response['status'] == 200) {
        print('Product updated successfully');
      } else {
        // Handle error response
        setState(() {
          if (response != null && response['message'] != null) {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
          }
        });
      }
    } catch (e, stackTrace) {
      print('Error updating product: $e');
      print(stackTrace);
      // Handle the error gracefully
      setState(() {
        errors = ['Error updating product. Please try again.'];
      });
    } finally {
      setState(() {
        isUpdatingProduct = false;
      });
    }
  }
}

